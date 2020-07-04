Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7850BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 09:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5281E20658
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 09:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRb3RKIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgGDJaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 05:30:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60885 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726259AbgGDJaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 05:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593855023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iQ2IbytdNT6KFkSEdiSlBviscTZ4cT4tmhaoTUCN8Kk=;
        b=QRb3RKIk9n9zZe3oirHlFdKo4wEuAxqZpeQhvUjMY8E999I7fSLsuEdiO2O7aOR779HbiI
        8e29X5Zu5YimQjoGemwR7MqgPh1w/zPGooSgRm6M/VfQb9H8ewaqfNaTFhW3vlRu7rKEoH
        hviZGFkHvIOvlfWSa05lhY9VgdJREo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-uApKl32hP2SZZ_OaEtmksw-1; Sat, 04 Jul 2020 05:30:13 -0400
X-MC-Unique: uApKl32hP2SZZ_OaEtmksw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF336107ACF3;
        Sat,  4 Jul 2020 09:30:11 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DEC357AC86;
        Sat,  4 Jul 2020 09:30:10 +0000 (UTC)
Date:   Sat, 4 Jul 2020 17:30:08 +0800
From:   Baoquan He <bhe@redhat.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Paul McKenney <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 1/3] crash: add VMCOREINFO macro to define offset in a
 struct declared by typedef
Message-ID: <20200704093008.GA23574@MiWiFi-R3L-srv>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618144919.9806-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/20 at 04:55pm, John Ogness wrote:
> The existing macro VMCOREINFO_OFFSET() can't be used for structures
> declared via typedef because "struct" is not part of type definition.
> 
> Create another macro for this purpose.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/crash_core.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 525510a9f965..43b51c9df571 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -53,6 +53,9 @@ phys_addr_t paddr_vmcoreinfo_note(void);
>  #define VMCOREINFO_OFFSET(name, field) \
>  	vmcoreinfo_append_str("OFFSET(%s.%s)=%lu\n", #name, #field, \
>  			      (unsigned long)offsetof(struct name, field))
> +#define VMCOREINFO_TYPE_OFFSET(name, field) \
> +	vmcoreinfo_append_str("OFFSET(%s.%s)=%lu\n", #name, #field, \
> +			      (unsigned long)offsetof(name, field))

Acked-by: Baoquan He <bhe@redhat.com>

>  #define VMCOREINFO_LENGTH(name, value) \
>  	vmcoreinfo_append_str("LENGTH(%s)=%lu\n", #name, (unsigned long)value)
>  #define VMCOREINFO_NUMBER(name) \
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

