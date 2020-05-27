Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EACC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6862073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="AFDSD49c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgE0S45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgE0S45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:56:57 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7773C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:56:56 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id be9so21173363edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhcFFsKj7N+XV8AMHJECIG5DAX+f8KJohJMbtgsnPKk=;
        b=AFDSD49cFylraLBD8OCsBvKLCgfANQjtXQzpSAYlTF6Rv8Dyagb3TLPZK1G4myVkYi
         cgrEWZNeCtmNDURPKDi156IaV5KGpxIVtFJq1iysfivwJJn+Hqk6RHU+hxBMeGeHJItx
         qrrdgEi8Tk4gM7dnw9RHhVlFwcE2Vs4DRPoYlcHOd8rW8L5cDBPOhMKneNPwniAKfSoM
         qYrZxyEpn9GeZhMDVEie/I+AKvGmV+tKYBTpLQA06+dcCFjFFUriCuv45ObESJGVixQn
         O0UBFJhYwsMUNrOWlOLZBzc8n/Ci/6z3XT8+LU0DgS8TI1HKkWmsED5ysHTFpPNc2+eC
         /iJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhcFFsKj7N+XV8AMHJECIG5DAX+f8KJohJMbtgsnPKk=;
        b=Y1hM6z4UvBVqawhiBTW1SVEAueMX7SZpN1LQELswjlwXjuCyEkd6H0kKVqC34TdOye
         yfsBgGxkILmRoA7/SkfdjcxyYsaIsbdulubkqYn1tTXIyRP3SlifOrwg7znpnmz9JClO
         8OZTcMsJFi2fSAY3vkrOfMS7LcN4VWrpgMkVChEUCv4Lqz1JTqPaxf/3+WnlP87O7+T9
         ZZyrNf8XZHmVhssNvxVvysWaQJucaj/z9hCYmp4Kf8TAZKEzgW/N2rMHZkboLpXqYtia
         x1sX0W2HBREJrEH7ewwdGYHgW0V4xwvHc9JkYuRckwvf8xIxtKavJlqlA2H3Gs2bRR/D
         WG/Q==
X-Gm-Message-State: AOAM530Do5ADc08HkjVh5w3OXWSDbbqVIdH//1necQ10HZoqwIu+8cID
        rWavOw3SBY5yf4hPeyjzeQsWdR+EBE4vvLI/RBuwwpXt
X-Google-Smtp-Source: ABdhPJwI+ATlYbLOn+OYCZPcy6MrH5Uw8AiuZ7BVCw67ST1mkLWvplIHlYCQn8Tp39Sljyhjk/Tm+0wSN17kQ6/Jzk4=
X-Received: by 2002:a05:6402:1c1e:: with SMTP id ck30mr24473373edb.154.1590605815518;
 Wed, 27 May 2020 11:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200527041244.37821-1-vaibhav@linux.ibm.com> <20200527041244.37821-2-vaibhav@linux.ibm.com>
In-Reply-To: <20200527041244.37821-2-vaibhav@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 May 2020 11:56:44 -0700
Message-ID: <CAPcyv4jXp1FocSe-fFBA_00TnsjPudrBCuHBfv+zwHA_R0353A@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] powerpc: Document details on H_SCM_HEALTH hcall
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 9:13 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Add documentation to 'papr_hcalls.rst' describing the bitmap flags
> that are returned from H_SCM_HEALTH hcall as per the PAPR-SCM
> specification.
>

Please do a global s/SCM/PMEM/ or s/SCM/NVDIMM/. It's unfortunate that
we already have 2 ways to describe persistent memory devices, let's
not perpetuate a third so that "grep" has a chance to find
interrelated code across architectures. Other than that this looks
good to me.

> Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
> v7..v8:
> * Added a clarification on bit-ordering of Health Bitmap
>
> Resend:
> * None
>
> v6..v7:
> * None
>
> v5..v6:
> * New patch in the series
> ---
>  Documentation/powerpc/papr_hcalls.rst | 45 ++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/powerpc/papr_hcalls.rst b/Documentation/powerpc/papr_hcalls.rst
> index 3493631a60f8..45063f305813 100644
> --- a/Documentation/powerpc/papr_hcalls.rst
> +++ b/Documentation/powerpc/papr_hcalls.rst
> @@ -220,13 +220,50 @@ from the LPAR memory.
>  **H_SCM_HEALTH**
>
>  | Input: drcIndex
> -| Out: *health-bitmap, health-bit-valid-bitmap*
> +| Out: *health-bitmap (r4), health-bit-valid-bitmap (r5)*
>  | Return Value: *H_Success, H_Parameter, H_Hardware*
>
>  Given a DRC Index return the info on predictive failure and overall health of
> -the NVDIMM. The asserted bits in the health-bitmap indicate a single predictive
> -failure and health-bit-valid-bitmap indicate which bits in health-bitmap are
> -valid.
> +the NVDIMM. The asserted bits in the health-bitmap indicate one or more states
> +(described in table below) of the NVDIMM and health-bit-valid-bitmap indicate
> +which bits in health-bitmap are valid. The bits are reported in
> +reverse bit ordering for example a value of 0xC400000000000000
> +indicates bits 0, 1, and 5 are valid.
> +
> +Health Bitmap Flags:
> +
> ++------+-----------------------------------------------------------------------+
> +|  Bit |               Definition                                              |
> ++======+=======================================================================+
> +|  00  | SCM device is unable to persist memory contents.                      |
> +|      | If the system is powered down, nothing will be saved.                 |
> ++------+-----------------------------------------------------------------------+
> +|  01  | SCM device failed to persist memory contents. Either contents were not|
> +|      | saved successfully on power down or were not restored properly on     |
> +|      | power up.                                                             |
> ++------+-----------------------------------------------------------------------+
> +|  02  | SCM device contents are persisted from previous IPL. The data from    |
> +|      | the last boot were successfully restored.                             |
> ++------+-----------------------------------------------------------------------+
> +|  03  | SCM device contents are not persisted from previous IPL. There was no |
> +|      | data to restore from the last boot.                                   |
> ++------+-----------------------------------------------------------------------+
> +|  04  | SCM device memory life remaining is critically low                    |
> ++------+-----------------------------------------------------------------------+
> +|  05  | SCM device will be garded off next IPL due to failure                 |
> ++------+-----------------------------------------------------------------------+
> +|  06  | SCM contents cannot persist due to current platform health status. A  |
> +|      | hardware failure may prevent data from being saved or restored.       |
> ++------+-----------------------------------------------------------------------+
> +|  07  | SCM device is unable to persist memory contents in certain conditions |
> ++------+-----------------------------------------------------------------------+
> +|  08  | SCM device is encrypted                                               |
> ++------+-----------------------------------------------------------------------+
> +|  09  | SCM device has successfully completed a requested erase or secure     |
> +|      | erase procedure.                                                      |
> ++------+-----------------------------------------------------------------------+
> +|10:63 | Reserved / Unused                                                     |
> ++------+-----------------------------------------------------------------------+
>
>  **H_SCM_PERFORMANCE_STATS**
>
> --
> 2.26.2
>
