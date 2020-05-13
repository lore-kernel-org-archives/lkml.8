Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223C0C2D0FB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034E123127
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589337755;
	bh=p9y9a3QyMJxo3k2kNaZVRf0AFIIDm4OTYEkMkDePs1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LvHCVbxUlQIpsER1eMz+8yfAbpyK7ma09/oz7DhC/qiHXUgJQfYcOP5GwLXbWAZuq
	 971Bhm1dKWR0SdxgoDotFAw11VUPwciwXjqDKAeSkvFVr0/5Tus83cwnfOhIsQOxtX
	 b6l8rxYCKYNU4sb/gkwFc4l7s+k7WlPTbHbjMjjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgEMCme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 22:42:34 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35824 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEMCme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:42:34 -0400
Received: by mail-ot1-f67.google.com with SMTP id k110so12279989otc.2;
        Tue, 12 May 2020 19:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2bMFR9ZrgzOQlH0FlvnvdFeLoRnipB/ORGSjRz0EVps=;
        b=iV305tQZ6TmyhB2c9kBH2Z1qRXsD3Xuju30Kb3u5+AhvqVDjyDoup7p3iWfHcpoih4
         QmBcXHob3WyGUl7ZpmDHUjYXWs9UbBqur5li52P+FypUcJG/Bpjx4fd9a0OxRQ2tpxsz
         peljOWmj5D7lzy8zGM8ucwWYpvrWnILaFgbDdHOwpWoV4LjZyiuLb0IKTQG8qkxGxfzz
         dVWRNZp5FFBb+KQx3/SbrTBH7Q802jhJ9JHrMk/jwoPji6ttoNtXumAGn5kyasqiOLwv
         Oa1hAS2VTT3KYIWHSJLr0GRoD3FwVrEdCo6u9XI0A7KcTPMKjj3SvS/kuICkg4SdFJmp
         SqPg==
X-Gm-Message-State: AGi0Pubv3oshbafhRyTPiOTBq2pc+xDq62VHeaa57mbM4vfbqCM4NXmn
        bNb8QAAGqNd6EfIN0eZDUQ==
X-Google-Smtp-Source: APiQypLBEyIuv7R37kJCZ3zR8tQwf7xBblI1Bgjqy2437+/2qxUEX5u/run7rNEJgzhwZrmLw59oHQ==
X-Received: by 2002:a9d:d07:: with SMTP id 7mr19762517oti.338.1589337753062;
        Tue, 12 May 2020 19:42:33 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f20sm3920467otp.61.2020.05.12.19.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 19:42:32 -0700 (PDT)
Received: (nullmailer pid 5606 invoked by uid 1000);
        Wed, 13 May 2020 02:42:30 -0000
Date:   Tue, 12 May 2020 21:42:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ramoops: add max_reason optional field to ramoops
 DT node
Message-ID: <20200513024230.GA3514@bogus>
References: <20200505154510.93506-1-pasha.tatashin@soleen.com>
 <20200505154510.93506-6-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505154510.93506-6-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 11:45:10AM -0400, Pavel Tatashin wrote:
> Currently, it is possible to dump kmsges for panic, or oops.
> With max_reason it is possible to dump messages for other
> kmesg_dump events, for example reboot, halt, shutdown, kexec.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  .../devicetree/bindings/reserved-memory/ramoops.txt    | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> index 0eba562fe5c6..886cff15d822 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> +++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> @@ -30,7 +30,7 @@ Optional properties:
>  - ecc-size: enables ECC support and specifies ECC buffer size in bytes
>    (defaults to 0: no ECC)
>  
> -- record-size: maximum size in bytes of each dump done on oops/panic
> +- record-size: maximum size in bytes of each kmsg dump.
>    (defaults to 0: disabled)
>  
>  - console-size: size in bytes of log buffer reserved for kernel messages
> @@ -45,7 +45,13 @@ Optional properties:
>  - unbuffered: if present, use unbuffered mappings to map the reserved region
>    (defaults to buffered mappings)
>  
> -- no-dump-oops: if present, only dump panics (defaults to panics and oops)
> +- max_reason: maximum reason for kmsg dump. Defaults to 2 (dump oops and

max-reason

> +  panics). Can be set to INT_MAX to dump for all reasons. See
> +  include/linux/kmsg_dump.h KMSG_DUMP_* for other kmsg dump values.
> +
> +- no-dump-oops: deprecated, use max_reason instead.
> +  if present, and max_reason is not specified is equivalent to
> +  max_reason = 1 (KMSG_DUMP_PANIC).
>  
>  - flags: if present, pass ramoops behavioral flags (defaults to 0,
>    see include/linux/pstore_ram.h RAMOOPS_FLAG_* for flag values).
> -- 
> 2.25.1
> 
