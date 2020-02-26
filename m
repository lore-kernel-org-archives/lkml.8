Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F1DC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46F624656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582750579;
	bh=NCXGFtPhJ0nwcoqRAqQIWRRgiLD61nrPMHnLjbVs1ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YpicplvSe7tI33FFBikNXX7xfdHJjzodvTjMrKn7HyCxxsyXYQ9Khy2rQuJKUjY8l
	 wJplzKHgUDzsC9jvUA1J8pM8+jbB9MGHp52eKYlSKGUGKwTTjlrcSH5GNQLD0Sl8MA
	 3gNnkx0w8w31TZQ1D7d8EZ1xTeTj7MC9qSmqYvc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgBZU4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:56:17 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40978 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgBZU4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:56:17 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so958277oie.8;
        Wed, 26 Feb 2020 12:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J9qgrozapssERsonDJI4GpvhEeaddHXMd1Trv7tVEP0=;
        b=pWe/NpDccvchiIL49k2Tms7Y/65YFrGUcfNxnHkQzWU00QO/w4sjdPkS8xUsn+joDH
         GWyNu3NZJjf5LM7z/nvbbEZU4NNniGopzwUHrE3e/Z653n8C0lb58BGv9JMZVPGMw2ai
         bFUD3/V/3mZeym9+VDdT5wXVSnFeQAedAUO6RVSdoVqLjZRwdmUbMnK+Z8vLZlE6L4x/
         XVBqHz9Xq7sqccGHtpwwzKSGtMIEybr0+/5/NooSexhn/vZ/YQAgqR0u67uha6t+rx9v
         4Cqlic9bJ2jtX5CGkrzjU7yjpGXLQ5UgvyDbjzmb3I0a1MdWFYmINplDdRa1Jn7R1RCm
         IyQQ==
X-Gm-Message-State: APjAAAUaQr16w/Xr548xU6EcED5ox0N6RLxGY1a6xR0fhEaySyI1cehX
        FtzotSt1h8/+x44/H2SWYA==
X-Google-Smtp-Source: APXvYqzjCn9YznzSy14Mhiha1jTy5ZQd90eC1T9N78Qew6zTeL1LsI9hC32rsKLmBzZ+eHDUQeI2Mw==
X-Received: by 2002:aca:190a:: with SMTP id l10mr773765oii.56.1582750576567;
        Wed, 26 Feb 2020 12:56:16 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m185sm1187716oia.26.2020.02.26.12.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 12:56:15 -0800 (PST)
Received: (nullmailer pid 10421 invoked by uid 1000);
        Wed, 26 Feb 2020 20:56:14 -0000
Date:   Wed, 26 Feb 2020 14:56:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        david@gibson.dropbear.id.au, sjg@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, devicetree-compiler@vger.kernel.org,
        Ian Lepore <ian@freebsd.org>
Subject: Re: [RFC PATCH v2 4/4] script: make automatic dtb build info
 generation
Message-ID: <20200226205614.GA15331@bogus>
References: <20200221161418.20225-1-alexandre.torgue@st.com>
 <20200221161418.20225-5-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221161418.20225-5-alexandre.torgue@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 05:14:18PM +0100, Alexandre Torgue wrote:
> Append each "xxx.dtb.dts.tmp" file with "build-info" entry during dtb
> build. It allows to get build information (date, source version, ...)
> for each device tree without modify them manually.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index a5af84ef4ffc..f084e78267b2 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -289,6 +289,7 @@ quiet_cmd_dtc = DTC     $@
>  cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>  	$(DTB_GEN_INFO) $(src) ; \

We regenerate this for every dtb?

>  	$(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
> +	$(DTB_GEN_INFO) $(src) $(dtc-tmp) ; \
>  	$(DTC) -O $(2) -o $@ -b 0 \
>  		$(addprefix -i,$(dir $<) $(DTC_INCLUDE)) $(DTC_FLAGS) \
>  		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
> diff --git a/scripts/gen_dtb_build_info.sh b/scripts/gen_dtb_build_info.sh
> index 0cd8bd98e410..72f31e386787 100755
> --- a/scripts/gen_dtb_build_info.sh
> +++ b/scripts/gen_dtb_build_info.sh
> @@ -6,5 +6,7 @@ set -o nounset
>  DTB_DIR=$1
>  DTB_COMPILE_BY=$(whoami | sed 's/\\/\\\\/')

Use LINUX_COMPILE_BY #define

>  DTB_INFO="From Linux $KERNELRELEASE by $DTB_COMPILE_BY the $(date).\0"

I'd use UTS_RELEASE and UTS_VERSION defines here.

> +DTS_FILE=$2
>  
> -printf "$DTB_INFO" > "$DTB_DIR/dtb-build.txt"
> +printf "$DTB_INFO" > "arch/arm/boot/dts/dtb-build.txt"

Obviously, hardcoding this is not right. You probably need to prepend 
with $(obj) so this works for out of tree builds too.

> +echo "&{/} {build-info = /incbin/(\"dtb-build.txt\");};" >> $DTS_FILE

You could commit the .dtsi file using the above defines and then just 
add a #include of it here. Then we'd get dependency tracking for free.

Rob
