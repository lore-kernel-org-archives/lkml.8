Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED64EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C705020739
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2zYcdJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgFPI2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFPI2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:28:32 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0A1C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:28:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dr13so20517923ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8IjNpcb5GlLP8oh8x0KUTPeP/cupRlI8efPDAe078Wg=;
        b=n2zYcdJI10LwDXrUDK71pELIpej3d4vK23sWHQIG+DTNiP7rBB2Ydlo3ni2NhqKlw0
         qmgjqRyWrTNKRJqtcN54fNNbVchNxv0UCZ8UD6A5n0N9veGqYXg67ZE1JHCqEN7GwO5N
         bEzMy2pQBU1i7k0Z/9BJp4fSpA1uwPrI9uPISnm1l2c83I4urBxMP6qXHOXcm7LqT474
         DkWGGV7iqbwvNUH1ffz861zJTpj+CcmYfrKxZNalIwc2nhiDZQK3HmY8x01t6j0g8Rzp
         21hq2PicDxmT3+wENPx4ZJnox12QbkNo3+5pkq+RlLl6x1a38Mh53C7YsX6mxJYhTMLu
         rlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8IjNpcb5GlLP8oh8x0KUTPeP/cupRlI8efPDAe078Wg=;
        b=fwYq5EQnKm71+91zxCqQ2TGBeJYAClgx91+F/A0WG/1TaTcJuVgSeycPzGjp2lBuOZ
         ZjUJykizoJa7w2xvH+yQvOJOlsQU1K6I3KIDVb30S0ZJ7VZotyGFcwf2CmwLhIr1Iwlj
         Vbf9Gxo0laWxYwECGK1XantwYZ8HqPHUdW7vdk0sDykLj4Z23wuVwihjpWO5X6OaxSMz
         CskseS1UKSAZMTjGhZ27KxeHXCDpMoLjn4CG8sTQ9r7zFV8Y/R+smBq25QxMATLbsH8i
         IE0pXi38hVRF+9qKCO5njZwkEna8G9dzjRtwtvSZ5F1UrplNAvAd9SrYOg8E3xJoktvC
         8PEQ==
X-Gm-Message-State: AOAM531CpzvHfIS9Kb2Gqb856BrOYa6v/NYaQUlW4QSLrrSdz/ykyef4
        18L+A8Vyew8lnjQZ9E4SFzp1JA==
X-Google-Smtp-Source: ABdhPJwdmGZqCbPQVfP2PbF9SY5ULvsP9RvSngnjuu0AyNddv0ojHPfA/jhOP8zjYvYdGToRfiyJAw==
X-Received: by 2002:a17:906:6b92:: with SMTP id l18mr1733654ejr.145.1592296110725;
        Tue, 16 Jun 2020 01:28:30 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c4sm10680797ejz.104.2020.06.16.01.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:28:30 -0700 (PDT)
Date:   Tue, 16 Jun 2020 10:28:19 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        iommu@lists.linux-foundation.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 08/12] mm: Define pasid in mm
Message-ID: <20200616082819.GA590740@myrica>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-9-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592008893-9388-9-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 05:41:29PM -0700, Fenghua Yu wrote:
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 64ede5f150dc..5778db3aa42d 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -538,6 +538,10 @@ struct mm_struct {
>  		atomic_long_t hugetlb_usage;
>  #endif
>  		struct work_struct async_put_work;
> +
> +#ifdef CONFIG_PCI_PASID

Non-PCI devices can also use a PASID (e.g. Arm's SubstreamID). How about
CONFIG_IOMMU_SUPPORT?

Thanks,
Jean

> +		unsigned int pasid;
> +#endif
