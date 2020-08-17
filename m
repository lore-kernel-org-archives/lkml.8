Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12347C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20C82080D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597647644;
	bh=BByRPdtlmPBqiNYFQurdmSiKVxzMphseSv7+CP5W2Fw=;
	h=From:To:Subject:Date:List-ID:From;
	b=SgTE9pvSbHYhogltUqUQpWRL9xKmhFdu6e/9dQUFgb5uaDSl2p5EdNTYesK3WHYcO
	 2x7fVj7muGZ/3scDX4cGcQMO2PDGjw5MM6o+HpHIOzVdl0mKJyc5PvW9adRi1pBK2U
	 O5/YTvsw6ZaD0efTu478MfXHfigQ4MCWbYkVOG+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHQHAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgHQHAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:00:18 -0400
Received: from localhost.localdomain (unknown [194.230.155.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94CC62078A;
        Mon, 17 Aug 2020 07:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597647618;
        bh=BByRPdtlmPBqiNYFQurdmSiKVxzMphseSv7+CP5W2Fw=;
        h=From:To:Subject:Date:From;
        b=EehskzrYLeh8tbHSTQM67ZrN76rYYsTKRoG2eA4WK2UOXYA9wYzgsk9kBZPDCAcrF
         zsIP3qPpSN9nGkTHceVYsNSfL7gfheC3zO8mgzpj1vUDUj5GWT4u+LbdezjFaGmSA8
         qfnC3wvZnQAoFJ/5FS4/2tV0J42BPHu0H2H5hIyA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 00/13] extcon: ptn5150: Improvements and fixes
Date:   Mon, 17 Aug 2020 08:59:56 +0200
Message-Id: <20200817070009.4631-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1:
1. Mutex unlock fix in patch 8/13.

Best regards,
Krzysztof
