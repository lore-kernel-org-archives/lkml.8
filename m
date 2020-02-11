Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95839C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B54E206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PMPjRvyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgBKMOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:14:36 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33022 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgBKMOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:14:36 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so7743954qto.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 04:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=LWIVZecHGHtxcasziXdqqFM5NALIahlfDA90LL4OfY0=;
        b=PMPjRvyPyxE5kwBQBUQVriUvTLehyHLXXFm1Xo0rcMWaQ7IEW/RJLResFzxk2mEelw
         kZT8SwoOLhKUNkEd3YCXd1h1NC9JXMeFpU3oeU4y61GfLO4vvu/uFEAHRRiSaH2VVw4r
         RaRznP3+CHNKArg8NdYWZU4cJSmeBJ4OQU6pg0qaknb3K3pZYJZ+DAg6Zi5X/0cIVXl/
         oGzqNNtGqjtq62Fm0jEJxN0of2/NSoixG5zp9F6kdM7MQSKaEjABcAfK6hqXdcSp9ItE
         QQDX/eqWDCkG6//qShDbC1RlBLTxpg0Ppr6dSSFgYIBWPybRhGaXUb90u6EnYBTpfwiu
         HTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=LWIVZecHGHtxcasziXdqqFM5NALIahlfDA90LL4OfY0=;
        b=hGrCMNohjDQRWVDT/fctf/lCjSOT0C3pRIgwuRFgb/aP47v27/92nemSFvZKsUYl8P
         N4VAwnLKyMSH4fuW2J/+aPcW8i878rnh99n/gk1gyqMIHp3AJrivxI8chQSKXlyd83DM
         CeQI3Govr6VdntbEXyeRM4uaBvwC7a0A4RyRA06ZsDC+6W4b5WDZAtkFaCoFyk7ohXhb
         Htm7BH/6XtH0bNlHPOsGNgbqwSFxqTDSBwoaxKpNB79Gc2d7F3fBXUW7oqvPmaMOkG7R
         +H9Ij46VDB5hCM42m9SluaS9t90ubtxWbX1iez41/sZk7b7hDvSo1WbyN9C4mD9Wtwc7
         iPPw==
X-Gm-Message-State: APjAAAX/frqHUNzoB2P47F/FuMaV9YpDTOhOx6QmOzUgQaCsZvs1XoYi
        3/Y7oX/X9GIk3KJ/wMJi+Qzt6OesRN4Swg==
X-Google-Smtp-Source: APXvYqxR2+5aBRq1XNSTJ6pSfrdpf65s9rXPJmx+5hAIOPr+Fk6Sl/DeYX0HVgyutWuNM+iSWJ//zA==
X-Received: by 2002:aed:2f45:: with SMTP id l63mr2154788qtd.221.1581423275332;
        Tue, 11 Feb 2020 04:14:35 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h4sm2015636qtp.24.2020.02.11.04.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 04:14:34 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_counter: fix various data races
Date:   Tue, 11 Feb 2020 07:14:34 -0500
Message-Id: <C868516E-CDCA-482A-B600-4AC148735E13@lca.pw>
References: <20200129120302.GJ24244@dhcp22.suse.cz>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, elver@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200129120302.GJ24244@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 29, 2020, at 7:03 AM, Michal Hocko <mhocko@kernel.org> wrote:
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Andrew, could you pick this as well if have not done so?
