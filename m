Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C402BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D17D20780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGMguE63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgF3ARa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgF3AR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:17:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF55C061755;
        Mon, 29 Jun 2020 17:17:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x8so6847362plm.10;
        Mon, 29 Jun 2020 17:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r1HqfD/T3DXsPo/ucZfIExKmt+62jYYO7GR0w6MGnrg=;
        b=VGMguE63P+6tyLQphqof7eKCF+lWUxjAISwvkTNF2WydMdZCobJ4u7yG98h7BCbg2R
         9P3b+Vweraar11ot4d9paM+T6u1jN/naTc+NhqG0Qak9E0lq6Mf0LHumd/R4b/hJBp6z
         co34Fk2QfFcPIzQcYE0T4qbFVL+RnUYWf6ELHdhR0Dh1bG7ey5oaxlcm+Y/JZTKYAw6o
         MQ93MiOChqz43N5JkM4Ttoe9tz77mfhF+2uVo6/WYVwA/vYPvXzHyBQ0imN5F7Pgl9cx
         ZG9QxKSBpdc68xOImv76r4YpM4ltXdPGzLznPuj4tqjOnQ4lp/jWsExizaQQm0iZdB0p
         mhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r1HqfD/T3DXsPo/ucZfIExKmt+62jYYO7GR0w6MGnrg=;
        b=SWzQtZAgx+dLu4CLDJ9blnlG+KnxlpSD07YbxlFEHmxHztuBIh5buV6vJdN/vX4qlR
         NDcQO76LWeZoK0C1KHXLy8jwDo3TkWtrYst1jbQLvR3mqMpZh2FTv5upKrWnOT2nkmTr
         k8SFIuz99on2yQuWi7L9Iijrf46ycN0mFlXfzVwYSULoK7TRE/cgN08QBcUFrtIoJG2/
         2SUnJ3+0WmxTLC56FikuV1ShK8bj2Guk7Z4ot1zfkTcXY7OKePUWdDrhhbDur9+G9j/K
         Ybm9Z0r1JymuspT7jWPbRZW60rGyAf02bFh+2ofS7o/7MOTwgF/frTjwUMZXTgf8eLaE
         M1lw==
X-Gm-Message-State: AOAM530RvvMWEYgn2PNpi1yYjGUWYVfSi4JvCMuRRXJmst9Lk1AUBk9i
        tgoverG+D5yfffhPVQFdRwo=
X-Google-Smtp-Source: ABdhPJyHaDJnlJiCoOdivw7ePpICgj7y00rh35CZ6z0jFTTfgqoZujwp/mFfMrLvO7rOd6cL+KWRCg==
X-Received: by 2002:a17:90a:a109:: with SMTP id s9mr21152590pjp.156.1593476249136;
        Mon, 29 Jun 2020 17:17:29 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 83sm703309pfu.60.2020.06.29.17.17.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2020 17:17:28 -0700 (PDT)
Date:   Mon, 29 Jun 2020 17:16:53 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com, yhsu@nvidia.com,
        snikam@nvidia.com, praithatha@nvidia.com, talho@nvidia.com,
        bbiswas@nvidia.com, mperttunen@nvidia.com, nicolinc@nvidia.com,
        bhuntsman@nvidia.com
Subject: Re: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for
 dual ARM MMU-500 usage
Message-ID: <20200630001652.GA7427@Asurada-Nvidia>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630001051.12350-2-vdumpa@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 05:10:49PM -0700, Krishna Reddy wrote:
> NVIDIA's Tegra194 SoC uses two ARM MMU-500s together to interleave
> IOVA accesses across them.
> Add NVIDIA implementation for dual ARM MMU-500s and add new compatible
> string for Tegra194 SoC SMMU topology.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
