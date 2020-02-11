Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF41C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962A9206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="GgoNVJMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgBKMQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:16:12 -0500
Received: from mail-qv1-f51.google.com ([209.85.219.51]:46405 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgBKMQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:16:12 -0500
Received: by mail-qv1-f51.google.com with SMTP id y2so4830045qvu.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 04:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=W05n4dUrPGi/8OqactW7+aYPEPNnSduX+Rw8KnLkys4=;
        b=GgoNVJMZYKU8cDrXJ3Lklf1y0G0guRKvCLcAq/R9t72W9MppqTVkO25danc7ocTQID
         m4mPATKouBQ8gJY8epW8uwalaiGokaoJs+iSc38HPDcLjCAwu5nkmKeyNdIctpm1fRq4
         osCEbt7U3wPtFyubsHcm+BG77SkpO4d8rFEXn6jV5eeaGHEgKRrqj0Y9/M1uBa3Wh2UV
         WSEKm3eAwihgic2hKZhEwkg+bmAriqF6hQHq+bJXFw0J+wN7S0MaQWsCXOuhgKD6vC6b
         ZO344y/hVU1tHPl4y3T/WrRdbZpLdoHCsk03XeEcacWH/rWwUfWfe+6jS/foTql6plYx
         GdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=W05n4dUrPGi/8OqactW7+aYPEPNnSduX+Rw8KnLkys4=;
        b=GQKq//pwXHBEo0ejLJf70enN9qNMyhEbd9wDnnAR7vJIFcJW/LKraaMnei528go2+d
         DxeQSNMmchK4SDh08zbwQrUiNwrg8aJ/cYNBCmOKNw8VqVIRwDrropaFldMyVpTMCHHB
         AWkA9HwWiuzcK+fwnEI93sG0NbYPesczK9E+ciwlKmLqTefYqJI5czKUsJ3vEOzVdPM6
         bc3BHtpluKuAmaZpo7NJVZGis9ETMLAJhej8BWZiauScQ8OsoN5FSrsltP2HS1OBSamY
         4HIyHrWeQSOZbXxKONfnnWj7I5hhEOl+YA5Jy74FyiFdN0ufCn8FMfanp313C08m5VtP
         3y8A==
X-Gm-Message-State: APjAAAVhXp+rcTk98M0IATXDIQIT85j0FQ1NF2Qdk4L/4TERfCisE5Ik
        eXRR0NqWmtHKsUPTD/YNwWe7eMpO/G00qg==
X-Google-Smtp-Source: APXvYqykcc8jK+GxUrm0y9yanrkLnmIyHsYeRRroRPnntCxSwPR+SydW5kCtI58pUzggrznvFdzxUg==
X-Received: by 2002:a0c:fca2:: with SMTP id h2mr2600682qvq.146.1581423371299;
        Tue, 11 Feb 2020 04:16:11 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b7sm2004305qtj.78.2020.02.11.04.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 04:16:10 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] mm/page_counter: annotate an intentional data race
Date:   Tue, 11 Feb 2020 07:16:10 -0500
Message-Id: <26C7B925-686E-4D09-9464-CB21675BE9DD@lca.pw>
References: <20200129132950.GL24244@dhcp22.suse.cz>
Cc:     akpm@linux-foundation.org, penguin-kernel@i-love.sakura.ne.jp,
        hannes@cmpxchg.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+f36cfe60b1006a94f9dc@syzkaller.appspotmail.com
In-Reply-To: <20200129132950.GL24244@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 29, 2020, at 8:29 AM, Michal Hocko <mhocko@kernel.org> wrote:
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Andrew, you might forget about picking this up too?
