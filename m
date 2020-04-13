Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D714C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757FB20753
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ALTaZ7vQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgDMKtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728779AbgDMKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:49:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63685C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 03:42:06 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h69so1745142pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TH0pnk/VsEjeKOC3kLKQXMgD8PcclZox9CcihSHYeO8=;
        b=ALTaZ7vQ3z2TO2h3fMvvjaw59xOJ+QUedKzDupvltJmlP/eokCYBVVq2qvdfbtnnoU
         kDRx0t/+bdLzv/BRgkp3LLvdMjzEBkvqUE/vbxppn156S4gQDaJbU/zDSDUt0MI/Qxtp
         E1lD1din+dmGo6GAweUClBrAXracPUhmz9Fgpp2yQezF9xkeLJPvYAk2YZwxarKJISQd
         nQBURZWHuUysrCReP1xcHpn0fgULzIt9fZmgW9BtjJ6QJGdXLrjMxddXX0ffL2Dd9Rdn
         bbI3eI7mDlqxuGFPcecGpuc0uBE69XP8V6gqV+6f51Sp5Ldz3CDvEPF1OZ1KR9/RBApP
         QzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TH0pnk/VsEjeKOC3kLKQXMgD8PcclZox9CcihSHYeO8=;
        b=L3lNL2kOSotKGLi20G4BmPJZwSMUObVnU32PmrwJSICi5UT239jXMmx/h1FyjVD8TB
         LYX0hTsflmxzUZb2oitQiGM3xpRLhsR+1sJACAlwt9BLuMsmkPvPscinbTAdtQ5mzmGb
         B61ce9d5UVEsJ2BWaq7QICDOEtpkkEEa4UBkumfAHZ0EjrImXtJeu9/xbn9VcK8X0OLF
         uOfoAGVXlLpKZSAieWn9VTyo2neDWnoKuWom0EY2ULJAYEzkdW0MSrPeyXciDcZTa3uc
         X0LL4znN5hDFi86J0w1n85dBwjEUbfDEhA2XxTfeoAXBHhCe1u4NVpl8WVzLwgFcQoqS
         nx4g==
X-Gm-Message-State: AGi0PuZOQ+FpDwsfDWJTVEvcOpi+5q1CEQdi5MPRVBHahzBgOhwnlm/4
        lMSJOc61My8t2HVGXYfMedD6SA==
X-Google-Smtp-Source: APiQypJp4dRx7UGBG7jKvk1NdYEZoA5TT+7A5HupoMRC9VvFfosYqFcq7QC1HTsAlLZ7t6XoF80H6w==
X-Received: by 2002:a62:3086:: with SMTP id w128mr17316837pfw.63.1586774525783;
        Mon, 13 Apr 2020 03:42:05 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id x71sm8287035pfd.129.2020.04.13.03.42.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 03:42:04 -0700 (PDT)
Date:   Mon, 13 Apr 2020 16:12:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     sboyd@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/21] opp: Manage empty OPP tables with clk handle
Message-ID: <20200413104203.gyb7icsxbhnvjbvx@vireshk-i7>
References: <1586353607-32222-1-git-send-email-rnayak@codeaurora.org>
 <1586353607-32222-2-git-send-email-rnayak@codeaurora.org>
 <20200409075724.7t3bt3oxaxoygldb@vireshk-i7>
 <78dcbda6-12d1-7a88-b1f9-a03fb0ba9b87@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78dcbda6-12d1-7a88-b1f9-a03fb0ba9b87@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-04-20, 16:04, Rajendra Nayak wrote:
> FWIK, no one should call a _of_add_opp_table_v2 in cases where there is no OPP in DT?
> The 'empty' OPP table from what I understand will be created by dev_pm_opp_set_clkname.
> A good case to look at is the PATCH 13/21 in this series. The driver I am modifying
> is used on sdm845/sc7180 and a host of other older qualcomm SoCs. Since i am adding
> support for perf state voting using OPP only on sdm845/sc7180 I want the existing
> platforms to just do what they were doing. Now thats not possible unless I start
> adding a bunch of if/else around every opp call in the driver to distinguish between
> the two.
> 
> I am a little surprised since I though the idea of doing something like this came from
> you :) (or perhaps Stephen, I somehow can't recollect)

Me only as I start remembering it now :)

> to avoid all the if/else conditions
> I had when I initially posted some of these changes.
> Btw, you had this patch reviewed when this was posted a long while back too [1]
> 
> [1] https://patchwork.kernel.org/patch/11027217/

That's an year back, in my defence :)

But anyway, I wasn't opposed to the idea now as well. I was just making sure all
things are handled well :)

-- 
viresh
