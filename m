Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF8AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE153206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6Ctstxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbgG0Ohb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:37:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28860 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732940AbgG0Oha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595860649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u5HKAp4ZUkGbVlQE18UlOQNKjizI/cY6UzIC6ImvqWM=;
        b=Y6Ctstxa01bguxMbIpM06aqH77wWdAFCBmDQlFypzoTFcAUZUA2edV88HNC15cBbnE5cet
        EBlToPRN8vYPJovnginvUu13omYmzpoq5JPSayh36M32eKtXvX8gYqry+/G/EKkjJk0ZjD
        pfZL22bjnA1abUC56QlRT8lxhJ/83TY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-s2Ng742HNvSm9bfzn1_uBw-1; Mon, 27 Jul 2020 10:37:27 -0400
X-MC-Unique: s2Ng742HNvSm9bfzn1_uBw-1
Received: by mail-wm1-f71.google.com with SMTP id b13so7896030wme.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u5HKAp4ZUkGbVlQE18UlOQNKjizI/cY6UzIC6ImvqWM=;
        b=t2SdBCu3qHm598GLMbb5aeEpGgCuVHjT1BB1e2Gg1iBXe10ynvXATwGpTOQRZRNqIs
         Fyr6deJTbAPZSxGiug4+MXpCyWoxlEl4NjgZL4oQZwnI2owPnaaqeh3ZjXlKPhAjeGp8
         3Rh39hqhyCqwi4pUK4xRrK3jwW1jgBKo9NEJNUyHLq3XlQC8JHvEjV78DWGoSugcr2HH
         blauhVzQCcBZKhrdKs8/vYR/yl3ec7Q1IVMUM1Mr+bm5ff7kcQU/8zkMDdEieXdvzvrX
         ivfCcd4onrC5xjheATBSfmyiP0R+hX5rFnsaeQCg6PcjQlZ81eexWe/XQr4kZ36MGaAU
         EpEA==
X-Gm-Message-State: AOAM531I602FL4pk7vz8sRHwJCGRg+nJ8V/ibUWzAaZDI1FC177L00/Y
        yCSYON6puFRu7tIDVtZXiHpXliQxjEbkJMt7spL23l7WGFVPOkCNTUTNCJULlEp6TSKOyhKQYw8
        6J8iQqpg1z1XASdFU91rYLo9p
X-Received: by 2002:adf:f248:: with SMTP id b8mr21851981wrp.247.1595860646125;
        Mon, 27 Jul 2020 07:37:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAQpp+VslCFH5JlkAq7a2IphD8QcADVVGEUVmcuWS0HNr9I77f3KRIAzXhaAX4q+h0XMcYwg==
X-Received: by 2002:adf:f248:: with SMTP id b8mr21851965wrp.247.1595860645912;
        Mon, 27 Jul 2020 07:37:25 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id z6sm7209387wml.41.2020.07.27.07.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 07:37:25 -0700 (PDT)
Date:   Mon, 27 Jul 2020 16:37:00 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Kieran Bingham <kbingham@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.19 42/86] scripts/gdb: fix lx-symbols gdb.error while
 loading modules
Message-ID: <20200727143700.rtouw4mgim4kjmeb@steredhat>
References: <20200727134914.312934924@linuxfoundation.org>
 <20200727134916.556617777@linuxfoundation.org>
 <7675dec9-7b66-b785-5034-22e8ede0b597@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7675dec9-7b66-b785-5034-22e8ede0b597@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 03:26:42PM +0100, Kieran Bingham wrote:
> Hi Greg, Sasha,
> 
> On 27/07/2020 15:04, Greg Kroah-Hartman wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > [ Upstream commit 7359608a271ce81803de148befefd309baf88c76 ]
> > 
> > Commit ed66f991bb19 ("module: Refactor section attr into bin attribute")
> > removed the 'name' field from 'struct module_sect_attr' triggering the
> > following error when invoking lx-symbols:
> 
> 
> Has ed66f991bb19 ("module: Refactor section attr into bin attribute")
> been backported to 4.19? It doesn't /sound/ like something that would
> require backporting unless something else depended up on it,  but if it
> hasn't been ... then *this* patch shouldn't be either...
> 
> Same for 5.4, and 5.7 that's just come in.
> 
> This patch will 'apply' cleanly, and not hit any compilation errors, as
> it only changes python code... so my reason to highlight is in case some
> automated system picked it up based on those assumptions.
> 
> If ed66f991bb19 has also been backported, then I'm sorry for the noise ;-)
> 

I had the same doubt, but I just saw that ed66f991bb19 was backported to
the stable branches (4.19, 5.4 and 5.7), so I think this backport is
correct.

Thanks,
Stefano

