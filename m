Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60E1C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6986421D20
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="WipNcCel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgIHIOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbgIHIOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:14:01 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4CDC061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 01:14:00 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g4so15104086edk.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P9yS5F51D4ggPT5sO3CXtYZY7IS+3p8Fe7sC8hbp+FY=;
        b=WipNcCelKnPDX+MMC+RhYHhyl2r7Y/UQRpi+V6LeVgin7a8cii5jfnN1pOriG87xvp
         zGerNJ7TN0DiXyTm35s5RAKC+V3DizCPWXKhYU4HVpzcX2wLYDu5uMsY+yLElR5lBrcq
         Jh20reQOD0kigW2bW13BcgxQ8ldtiMwY6OxYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P9yS5F51D4ggPT5sO3CXtYZY7IS+3p8Fe7sC8hbp+FY=;
        b=GEls9Vk8xrGOSTe+bQs1tI65uzxPSdsutuUo1DNQHuKDlbSHL3q2TOia8Cahsl+F+O
         EB0ieAC/WGugMlf9Mk9JMWMaAoxJlt98CcpTwwOaOrEMbQTzZZ1G4BgbEz22QbX2eP+U
         QnKHmHtBTqDBb6aVx7wzW2PLP3xH8vaAVXYcNA6dYzkd2TMWafOfmnBCqcVsLjYbu7Be
         HjEuBSBNeaIbuH2jlh5KhzGMfo+hCGg1tXFZaEIUEayrixd8zKB0fLrNOtfcVDHd8aiy
         +oGFVS7HRoHfpZgaOZJuAgp2Cd3maocOesp6v+s74en07TpHt2/KM1jChiaoYsNSs8uc
         M1ig==
X-Gm-Message-State: AOAM532VfynzTRYq2BRUN32RW9oUyfagx84nvHZ/3OjRPK/Q09+nBDPF
        MIKEAn1p7w3/1BEwCo5xhz/2tg==
X-Google-Smtp-Source: ABdhPJx7nWW1b3xNeHA9A0fJgW6LRQK46nQI3cMuR8JrMQqwezNkTlkDswsxTGvsFVZeFCzv3D2lCA==
X-Received: by 2002:a05:6402:50f:: with SMTP id m15mr26829900edv.41.1599552838858;
        Tue, 08 Sep 2020 01:13:58 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:4614])
        by smtp.gmail.com with ESMTPSA id g11sm16928457edt.88.2020.09.08.01.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:13:58 -0700 (PDT)
Date:   Tue, 8 Sep 2020 09:13:58 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: no one use charge_type
Message-ID: <20200908081358.GA1219116@chrisdown.name>
References: <1599552727-60003-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1599552727-60003-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Shi writes:
>After commit 0a31bc97c80c3f mm: memcontrol: rewrite uncharge API, no one
>using MEM_CGROUP_CHARGE_TYPE_xxx, let's remove them.
>
>Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>Cc: Johannes Weiner <hannes@cmpxchg.org>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: cgroups@vger.kernel.org
>Cc: linux-mm@kvack.org
>Cc: linux-kernel@vger.kernel.org

Acked-by: Chris Down <chris@chrisdown.name>
