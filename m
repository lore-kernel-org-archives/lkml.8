Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39911C433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1717620656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261800;
	bh=gtZEHtUNqFQ1blNIPEmqlbrDBTKZATeDlaf5BnoS8no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dXjTGsyBU/xnh8LF6AgXSkKCw0x8zBbaAZeOVx+zvLAC/71teL1gWcrn8oIelpfcJ
	 8ex4KO7jkid+MeaRLA/UCUxrrSD0nXYhuyNyoq2bKFinu+z9VUdjggMSKpPGL02j2k
	 AiDuHFmGin/SSESI77YGmQH6X2qjvw7f+dRqItrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733207AbgGTQQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387832AbgGTQQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:16:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0082064B;
        Mon, 20 Jul 2020 16:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261797;
        bh=gtZEHtUNqFQ1blNIPEmqlbrDBTKZATeDlaf5BnoS8no=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=enfeiATsysbXBCvbsnRQHXcfFuhWBuo2qGk3JPLkVtnXEWWXOxC5tmeVnh7Rb/g7T
         N5owIQViM81IQYiAJ1JZfdL3WlVoAmwslTRdQm2wgQZwpbk28ucc5GlC1EcIY6UH8R
         oVk9GriarckDgmolX4CsaiGTiQJ6/gJIYz+hNauc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Walter Lozano <walter.lozano@collabora.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5.7 205/244] opp: Increase parsed_static_opps in _of_add_opp_table_v1()
Date:   Mon, 20 Jul 2020 17:37:56 +0200
Message-Id: <20200720152835.603815751@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Walter Lozano <walter.lozano@collabora.com>

commit 6544abc520f0fff701e9da382110dc29676c683a upstream.

Currently, when using _of_add_opp_table_v2 parsed_static_opps is
increased and this value is used in _opp_remove_all_static() to
check if there are static opp entries that need to be freed.
Unfortunately this does not happen when using _of_add_opp_table_v1(),
which leads to warnings.

This patch increases parsed_static_opps in _of_add_opp_table_v1() in a
similar way as in _of_add_opp_table_v2().

Fixes: 03758d60265c ("opp: Replace list_kref with a local counter")
Cc: v5.6+ <stable@vger.kernel.org> # v5.6+
Signed-off-by: Walter Lozano <walter.lozano@collabora.com>
[ Viresh: Do the operation with lock held and set the value to 1 instead
	  of incrementing it ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/opp/of.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -733,6 +733,10 @@ static int _of_add_opp_table_v1(struct d
 		return -EINVAL;
 	}
 
+	mutex_lock(&opp_table->lock);
+	opp_table->parsed_static_opps = 1;
+	mutex_unlock(&opp_table->lock);
+
 	val = prop->value;
 	while (nr) {
 		unsigned long freq = be32_to_cpup(val++) * 1000;


