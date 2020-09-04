Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA34C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E072078E
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgIDNFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:05:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35199 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729297AbgIDNFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:05:03 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-lPIx2QwrN4G0pg7GL2iAYA-1; Fri, 04 Sep 2020 09:04:58 -0400
X-MC-Unique: lPIx2QwrN4G0pg7GL2iAYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 193E3801AF2;
        Fri,  4 Sep 2020 13:04:57 +0000 (UTC)
Received: from shodan.usersys.redhat.com (unknown [10.43.17.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5B411002D66;
        Fri,  4 Sep 2020 13:04:56 +0000 (UTC)
Received: by shodan.usersys.redhat.com (Postfix, from userid 1000)
        id 738A61C0C29; Fri,  4 Sep 2020 15:04:55 +0200 (CEST)
Date:   Fri, 4 Sep 2020 15:04:55 +0200
From:   Artem Savkov <asavkov@redhat.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        threeearcat@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pty: do tty_flip_buffer_push without port->lock in
 pty_write
Message-ID: <20200904130455.GA52548@shodan.usersys.redhat.com>
References: <20200901120157.3412245-1-asavkov@redhat.com>
 <20200904074333.GA410@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200904074333.GA410@jagdpanzerIV.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sergey,

On Fri, Sep 04, 2020 at 04:43:33PM +0900, Sergey Senozhatsky wrote:
> On (20/09/01 14:01), Artem Savkov wrote:
> [..]
> > It looks like the commit was aimed to protect tty_insert_flip_string and
> > there is no need for tty_flip_buffer_push to be under this lock.
> >
> [..]
> > @@ -120,10 +120,10 @@ static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
> >  		spin_lock_irqsave(&to->port->lock, flags);
> >  		/* Stuff the data into the input queue of the other end */
> >  		c = tty_insert_flip_string(to->port, buf, c);
> > +		spin_unlock_irqrestore(&to->port->lock, flags);
> >  		/* And shovel */
> >  		if (c)
> >  			tty_flip_buffer_push(to->port);
> > -		spin_unlock_irqrestore(&to->port->lock, flags);
> 
> Performing unprotected
> 
> 	smp_store_release(&buf->tail->commit, buf->tail->used);
> 
> does not look safe to me.
> 
> 
> This path can be called concurrently - "pty_write vs console's IRQ handler
> (TX/RX)", for instance.
> 
> Doing this
> 
> 	queue_work(system_unbound_wq, &buf->work);
> 
> outside of port->lock scope also sounds like possible concurrent data
> modification.
> 
> I'm not sure I see how this patch is safe.

Yes, indeed I see how this might be unsafe, but this argument doesn't
hold well with console drivers other than 8250 - most of them seem to
call tty_flip_buffer_push() outside of port->lock, many even unlock and
then relock right around this call to avoid similar possible deadlocks.
Even 8250 itself used to do this "recently". After all potentially
corrupted console is better than a deadlock.

I know this is no excuse to add unsafe code but unfortunately I don't
see a better solution at the moment, although admittedly I am not very
familiar with tty code.

-- 
 Artem

