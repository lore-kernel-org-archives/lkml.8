Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7820CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 569B52077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EinuUTTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGINS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:18:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52105 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726376AbgGINS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594300705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uai31VQPEZN9rwf7OACVSGu+VKSktCcJq5Sw/CwzuWw=;
        b=EinuUTTlujbGjr4xZyU7p/wo+Mvxq0TMdHv+5P2e1gpyUW0SMyDS1xvHIiasSBiV5F/0cw
        VxjnbuRFNn4+2EksL1sM7E7/mTDEPPcnnOe2dhtz8P1SYsZQdeeqmrmYFKjTTTczgHmlj3
        A7RDdc9mo1FXIEJdR5CzcvT8x+wAFGA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-SaIDNl0fMgilbK6kCKYFQw-1; Thu, 09 Jul 2020 09:18:24 -0400
X-MC-Unique: SaIDNl0fMgilbK6kCKYFQw-1
Received: by mail-qt1-f200.google.com with SMTP id q7so1572290qtq.14
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uai31VQPEZN9rwf7OACVSGu+VKSktCcJq5Sw/CwzuWw=;
        b=mJRqKgB2OOKDq7IkWgpgpLX4v4kdX5gLnGpb4d9xjKN4HPRtQnSriQsbUX7XddpDbP
         jvHa2SvbYLgs+JS4qUk9g/ROVy1hPERMXF5ch7Nj5WmAmVHG7t4rG2q989jIi8wlidTJ
         G1RwxAGXXrxc4U7LBlFem7QBB4So5ach4IOQC16fqOniWdGnYufpPVjD1eYQuCuedMLy
         sm7DklABIYrgqLDx6lO8aIIgwGi8iJ+mAjrltp/FbZslPxjLo5sdWAaVg1iYIyd1Pl4C
         FH6c6FHlu6EDdNgVLaaAkdEY33QiKuseIxCOB9dpPX6J1AI+9kN5z8iB2tBLDA93eLa/
         meng==
X-Gm-Message-State: AOAM533q2L3ADQhpX5VzFD2GQKst2ShWuhBirpH/Fd5XcwpiDAg7Ow1z
        m4Kd/97KMjGs+DSE/mC61jAITkvTvOax7cswnvgomPIPhmNzyDCjAx2OnnNm/YFv8DiM8P7ud7R
        E9LsI/lXD7pDkIVVACTC1A+VC
X-Received: by 2002:a37:8384:: with SMTP id f126mr63218162qkd.471.1594300701321;
        Thu, 09 Jul 2020 06:18:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7733/CHza1JSmzGYP3thc0Mpq3yjFhyLoQCKPyMkKUFdIFsXC4ZM3kw7kuIP92vg/wsKeMg==
X-Received: by 2002:a37:8384:: with SMTP id f126mr63218141qkd.471.1594300701089;
        Thu, 09 Jul 2020 06:18:21 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t57sm3733727qtc.91.2020.07.09.06.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 06:18:20 -0700 (PDT)
Subject: Re: [RESEND PATCH 1/2] fpga: dfl: pci: reduce the scope of variable
 'ret'
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com
References: <1594282337-32125-1-git-send-email-yilun.xu@intel.com>
 <1594282337-32125-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ef506ec6-d857-736b-e9e2-46077ab7d778@redhat.com>
Date:   Thu, 9 Jul 2020 06:18:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1594282337-32125-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think a better change is to use the ret variable, like this

--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -312,7 +312,7 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
                }
        }
 
-       return num_vfs;
+       return ret;
 }

The existing use of returning num_vfs is not right, the function should return 0/err not num_vfs. currently it is reusing the 0 passed in with num_vfs to mean disable as the 0 return status.  it should be properly returning ret.

Tom

On 7/9/20 1:12 AM, Xu Yilun wrote:
> This is to fix lkp cppcheck warnings:
>
>  drivers/fpga/dfl-pci.c:230:6: warning: The scope of the variable 'ret' can be reduced. [variableScope]
>     int ret = 0;
>         ^
>
>  drivers/fpga/dfl-pci.c:230:10: warning: Variable 'ret' is assigned a value that is never used. [unreadVariable]
>     int ret = 0;
>             ^
>
> Fixes: 3c2760b78f90 ("fpga: dfl: pci: fix return value of cci_pci_sriov_configure")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/dfl-pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 4a14a24..73b5153 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -285,7 +285,6 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
>  {
>  	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
>  	struct dfl_fpga_cdev *cdev = drvdata->cdev;
> -	int ret = 0;
>  
>  	if (!num_vfs) {
>  		/*
> @@ -297,6 +296,8 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
>  		dfl_fpga_cdev_config_ports_pf(cdev);
>  
>  	} else {
> +		int ret;
> +
>  		/*
>  		 * before enable SRIOV, put released ports into VF access mode
>  		 * first of all.

