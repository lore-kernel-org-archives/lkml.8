Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A12C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6A322253
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4lvu25T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgDSQz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:55:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27447 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725970AbgDSQz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587315327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vGICrycXQ813HE5piGlfG1KXzSs5G6rL6S2opOPLquo=;
        b=d4lvu25TYbgKdIxL53jMTBj7A/V4PduioHDN8sL8n/T2y1FEmYUEXpUe9kYpZ/lv3p7oU4
        35dQTmem/pg+V19ZjCci+HgkZ+f5djtXzD0of3iGp9QnohXjs2METigykrESZk+dnkumdt
        MKZwy3ZnVCEusLywtLb5hHgMt695N4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-4U55EugePyOS9oger1QR9Q-1; Sun, 19 Apr 2020 12:55:25 -0400
X-MC-Unique: 4U55EugePyOS9oger1QR9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 299FC107B767;
        Sun, 19 Apr 2020 16:55:24 +0000 (UTC)
Received: from treble (ovpn-112-237.rdu2.redhat.com [10.10.112.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58FA81001902;
        Sun, 19 Apr 2020 16:55:22 +0000 (UTC)
Date:   Sun, 19 Apr 2020 11:55:19 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [RFC][PATCH 5/7] x86/speculation: Change __FILL_RETURN_BUFFER to
 work with objtool
Message-ID: <20200419165519.wstqpqmvyom4yh3r@treble>
References: <20200416150752.569029800@infradead.org>
 <20200416151025.004441230@infradead.org>
 <20200419165155.4twgzmf6eusk7rv5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200419165155.4twgzmf6eusk7rv5@treble>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 11:52:00AM -0500, Josh Poimboeuf wrote:
> Are we still planning to warn about stack changes inside an alternative?
> If so then this would still fail...
> 
> In this case I think it should be safe, but I'm not sure how we can
> ensure that will always be the case for other alternatives.
> 
> And do the ORC entries actually work for this?  As far as I can tell,
> they would be associated with the .altinstructions section and not
> .text, so it wouldn't work.

My preference would be to move RSB stuffing out-of-line too, like you
did the retpolines.  Or use static branches.  Then we could add an
objtool warning to prevent stack changes in alternatives.

-- 
Josh

