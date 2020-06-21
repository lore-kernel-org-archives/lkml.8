Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765A6C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 22:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537A123E1E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 22:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnGaiWeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgFUWBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 18:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgFUWBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 18:01:13 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DDAC061794;
        Sun, 21 Jun 2020 15:01:13 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x18so17097987lji.1;
        Sun, 21 Jun 2020 15:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BY1JrAt2tQbJNgdurRfbYXwlMSOpveBFjJswmVovkYM=;
        b=SnGaiWeL7SKbZpHV6rJCmO+/QHLg6hOnB1zyX1ucOqooNjUYM1CBc58K2MiGaGsUmH
         0igjr8P2PZvMlevROuRac/vWFeThABujZSu0sJGYqyGVzzsyIUH2B438bx47IUHD0EZa
         RPxoDBKSZMGZzQomw/k7ZZ6329WD4E35hQkYnwWA4axr12G6NeZV9HO71E9J2+LfaXau
         DiBWgHOrPW3Agy+kk7/CuMML0yDpk9HNaEynlluyneZAFganF7XhMfbiPRf2HgUvjzvM
         8PutUsGp1GpVfBvInSOdKZHbJ7bsKzGIpczZe6nAijnO0iZ3CFefkosGlyx+stoE6zEJ
         KlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BY1JrAt2tQbJNgdurRfbYXwlMSOpveBFjJswmVovkYM=;
        b=PcYiJ/ODcfzhfVY6SUjmsnLIqxeJOKr6kbNCwsSC2Q85hfwMF2Tou+U7yd9anIqB2p
         3Xk/tcZxbUZhlbjWwUXehkvOS+W2F+qBaj5yz+sQezTAK+ybrYBu2EtKR66PYnv44y6Y
         zeFIf/IcCeg7KaRH3DG7GYxNy/eARg0FiieHtu2qVsb8QpsDfUv9nGpUu33UhNawG5Jd
         h6vBLP+7/Ue+3LtyjHqqBABAsqW95iVufjuVf/7okIezqhHow1JcdhRqaYVuyQdj5Q+K
         Ap0Mc6qxkbTpSpg/Xq0jWnsBavlMdrQalipPo+trekhaTafo4P4iJ/Q2jLYbvosIO0rE
         Yy2A==
X-Gm-Message-State: AOAM533UQQIMn4POfg9EGaHOxoiGtN0tLG1QjZEm/QN52w8abHommUXh
        52pfzRahwcBYGbfq0BCcsWA=
X-Google-Smtp-Source: ABdhPJw0hW3UsZaI1P4SQ6FurGayZ4X6GM2ZGiuyotBqWudUY+sHdfBN+QehmYoQnWLN1ooNmbLJaA==
X-Received: by 2002:a2e:9115:: with SMTP id m21mr6829178ljg.350.1592776871994;
        Sun, 21 Jun 2020 15:01:11 -0700 (PDT)
Received: from luk-pc.lan (host-46-186-7-151.dynamic.mm.pl. [46.186.7.151])
        by smtp.googlemail.com with ESMTPSA id q11sm2355729ljj.10.2020.06.21.15.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 15:01:11 -0700 (PDT)
From:   LuK1337 <priv.luk@gmail.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        LuK1337 <priv.luk@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] arm64: dts: qcom: Add support for Sony Xperia XA2/Plus/Ultra (Nile platform)
Date:   Mon, 22 Jun 2020 00:00:50 +0200
Message-Id: <20200621220050.649572-1-priv.luk@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200621213806.551879-8-konradybcio@gmail.com>
References: <20200621213806.551879-8-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Łukasz Patron <priv.luk@gmail.com>
