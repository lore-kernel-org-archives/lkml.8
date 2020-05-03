Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF89AC28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 19:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E3520707
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 19:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Hgghv2QJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgECTMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 15:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbgECTMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 15:12:18 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C860AC061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 12:12:17 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b188so14503859qkd.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 12:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=QjQNTEl64oFXby2DcLfNG1WpAuKAiDgue7kNNdacJts=;
        b=Hgghv2QJ8bnac2HvY//5dPe+3V01b//VZCjt/zPRvjM7sm9jIt80ZBdVClOxnSjU7b
         ilPS4ugIYt9vvS3ClL6ewC4aYHioCOtQci7kozyJPcCscPNunCZ1xZGpaPUwCxyh68UB
         /W6ac3C32vabUS5BIBVUqp30Vbe+cmgOuFcl2d6uM6HzgCoM2WgAwnPmstT9c8WjC1a6
         FxSRnJkjQcEzCHZQER1maDAD1hqApgStExaPBxzTFvp+LcXmQPxxabiQ7pxrAqrDqVKy
         6eUsHobeZdKy6+X4fwTVOj8KYu8CGTQ/VnKnZVEf+WneJ6MX1uJT3/t+Jjm0FWo1l4mO
         VqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=QjQNTEl64oFXby2DcLfNG1WpAuKAiDgue7kNNdacJts=;
        b=FxstjAbFkd/u+xepg+79rCd1sdMFS3/5MG7qV/tz7GL7xgP4dHKMB0JvMy9xGsvS47
         m0zwxB6ZuDwDo4C+2ZuVGwY2maXmhRY6X810Vw9R6sV1Dely2qQjyy6yexyhDpbn3IQj
         +oK/2ho12nhdpWn+Y3fnhhzy4vry5/fm1oDTD+AZFLRJNXXqivaKXvtKXeRH6SAZr2J8
         NQeF5n5i+cL0qYkaFSuE1bpDUOqKHJBxOkQuDziAvW+GChdFXSTXEblwjxLNxJjAvgIq
         JZtwTXcz4dgGwldJ/lQpSpes2cryUn21pv0hnW4CoQrY2c9cax+47980nmU2h4vwGQUn
         dt3Q==
X-Gm-Message-State: AGi0PuaELfz+mrGG0Of2stPAOvV9Wgw60XmjnMGpQ5Ww3TiJa56msOiw
        ZUGEYJrNGpu96EmOPSvUe1yb2oqK+bpcpQ==
X-Google-Smtp-Source: APiQypJibEKO4v/ek1bD86VUTy9GbWtdTI0sl6Lx3Eq8OG4JLinle7zFyUbyOwqebbSWTG5eTbuyuQ==
X-Received: by 2002:a37:6dc4:: with SMTP id i187mr13342595qkc.358.1588533136798;
        Sun, 03 May 2020 12:12:16 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t15sm9023400qtc.64.2020.05.03.12.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2020 12:12:16 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
Date:   Sun, 3 May 2020 15:12:15 -0400
Message-Id: <E18E118B-A79A-40A8-89D4-4B81C24FB486@lca.pw>
References: <20200503183927.GA18353@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200503183927.GA18353@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 3, 2020, at 2:39 PM, Joerg Roedel <joro@8bytes.org> wrote:
> 
> Can I add your Tested-by when I
> send them to the mailing list tomorrow?

Sure. Feel free to add,

Tested-by: Qian Cai <cai@lca.pw>
