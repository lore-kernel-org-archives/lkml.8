Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3163FC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C9F20CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257922;
	bh=DtpDea+8OatmEQy5UDzS7om+u5SF9Zt+/qclYmZu9qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HngMVzy7OWz+oH45OthU8Douf1e9u9x01XmzyumAuOBXUURgumcMwsE9aqx2r/EI6
	 iZ3iuwX26nayHkZxos2rKIBoZV6d85UzQM1wC8dl9I8qoMRto3QjSLfoe4yw/55n1Q
	 aLqIKis9yJ+BEDfWRHojr+q5b+JnzHviM7DZaJts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbgCCRwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:52:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732071AbgCCRv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:51:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E892214D8;
        Tue,  3 Mar 2020 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257917;
        bh=DtpDea+8OatmEQy5UDzS7om+u5SF9Zt+/qclYmZu9qI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3jHh51fUh6tV4wMR1R/ZUjiqj5LWdwsv660VLEbND6TUP2tInPlM9RJytCpnoWxM
         ApiMEFE0qRhHdTwc9jDTvHoAD5qb1zvYJsTYHCIkRK9E5/OsT6ilEIPkpSDd3xtYrT
         LkVBPsOAVKS+LS6xWXWKwNxycC3/H5nR2VZ+d3FE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.5 167/176] clk: qcom: rpmh: Sort OF match table
Date:   Tue,  3 Mar 2020 18:43:51 +0100
Message-Id: <20200303174323.396746970@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit 9e0cda721d18f44f1cd74d3a426931d71c1f1b30 upstream.

sc7180 was added to the end of the match table, sort the table.

Fixes: eee28109f871 ("clk: qcom: clk-rpmh: Add support for RPMHCC for SC7180")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lkml.kernel.org/r/20200124175934.3937473-1-bjorn.andersson@linaro.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/qcom/clk-rpmh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -481,9 +481,9 @@ static int clk_rpmh_probe(struct platfor
 }
 
 static const struct of_device_id clk_rpmh_match_table[] = {
+	{ .compatible = "qcom,sc7180-rpmh-clk", .data = &clk_rpmh_sc7180},
 	{ .compatible = "qcom,sdm845-rpmh-clk", .data = &clk_rpmh_sdm845},
 	{ .compatible = "qcom,sm8150-rpmh-clk", .data = &clk_rpmh_sm8150},
-	{ .compatible = "qcom,sc7180-rpmh-clk", .data = &clk_rpmh_sc7180},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, clk_rpmh_match_table);


