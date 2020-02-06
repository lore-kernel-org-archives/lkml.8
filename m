Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B07C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267B9214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pjgmdhml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgBFHaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 02:30:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46183 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727904AbgBFHaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 02:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580974253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RDgB6g2ZvA/Ut5iIJr1OGLu1IXUQU97q2dZMGoQowgc=;
        b=PjgmdhmlV8KFQMsFKFlIimxxiQjGe1YbsF8KMLrEgPVsgZhRjXrPBoPX6LMVevG/RJfamX
        Kv9Rl3aSFRFTw8IU62Xs7Wh8ILZzc2P4V9UFuaP7sl7InJbf6sN/SAns4wlVuyTJj5Gp4I
        3khSUu3ZRb/Akws8Y2mMH1IzB/bv3iA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-Go4GNvNyO-GK14Jg8jQ9uw-1; Thu, 06 Feb 2020 02:30:51 -0500
X-MC-Unique: Go4GNvNyO-GK14Jg8jQ9uw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3388FDB2E;
        Thu,  6 Feb 2020 07:30:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-108.pek2.redhat.com [10.72.12.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 526AB5C1B2;
        Thu,  6 Feb 2020 07:30:42 +0000 (UTC)
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
 <20200205044848.GH41358@google.com> <20200205050204.GI41358@google.com>
 <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
 <20200205063640.GJ41358@google.com> <877e11h0ir.fsf@linutronix.de>
 <20200205110522.GA456@jagdpanzerIV.localdomain>
 <87wo919grz.fsf@linutronix.de>
From:   lijiang <lijiang@redhat.com>
Message-ID: <06915ce1-f3ec-bb39-c00e-d0bcd63189eb@redhat.com>
Date:   Thu, 6 Feb 2020 15:30:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87wo919grz.fsf@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2020=E5=B9=B402=E6=9C=8805=E6=97=A5 23:48, John Ogness =E5=86=99=
=E9=81=93:
> On 2020-02-05, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>> 3BUG: KASAN: wild-memory-access in copy_data+0x129/0x220>
>> 3Write of size 4 at addr 5a5a5a5a5a5a5a5a by task cat/474>
>=20
> The problem was due to an uninitialized pointer.
>=20
> Very recently the ringbuffer API was expanded so that it could
> optionally count lines in a record. This made it possible for me to
> implement record_print_text_inline(), which can do all the kmsg_dump
> multi-line madness without requiring a temporary buffer. Rather than
> passing an extra argument around for the optional line count, I added
> the text_line_count pointer to the printk_record struct. And since line
> counting is rarely needed, it is only performed if text_line_count is
> non-NULL.
>=20
> I oversaw that devkmsg_open() setup a printk_record and so I did not se=
e
> to add the extra NULL initialization of text_line_count. There should b=
e
> be an initializer function/macro to avoid this danger.
>=20
Good findings. Thanks for the quick fixup, it works well.

Lianbo

> John Ogness
>=20
> The quick fixup:
>=20
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index d0d24ee1d1f4..5ad67ff60cd9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -883,6 +883,7 @@ static int devkmsg_open(struct inode *inode, struct=
 file *file)
>  	user->record.text_buf_size =3D sizeof(user->text_buf);
>  	user->record.dict_buf =3D &user->dict_buf[0];
>  	user->record.dict_buf_size =3D sizeof(user->dict_buf);
> +	user->record.text_line_count =3D NULL;
> =20
>  	logbuf_lock_irq();
>  	user->seq =3D prb_first_seq(prb);
>=20

