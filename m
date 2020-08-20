Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3541EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0532020724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916162;
	bh=CB91mRZZtwRX5Rs6Z2McPo2ROvipo0Nrx6PjkXAUo9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l1fsnTAOEOUWwQNTe9OGziZJ8DquHwseHYWpI2bf/wfGy5zl5yyZblyBlOVrFv/wq
	 bTPbedmzDRv7zOwN0Ml/Jk9OKS0uX5z88lcqur8A3Yre3tAHxlBxDSBr+t+higCvFh
	 8UOs49pJBebYNTzcTA9mZF8hsRygA3LUATcJBT5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgHTJf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbgHTJfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:35:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D3B2208E4;
        Thu, 20 Aug 2020 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916146;
        bh=CB91mRZZtwRX5Rs6Z2McPo2ROvipo0Nrx6PjkXAUo9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i236QKnVf4iU0Z2sSij8NInA0MXCeF/o8Te4VdEoNCg3ScqboZgdoYJniDd9lhkfE
         Sfx/+27AUopK2+CvijBSmw8KB3SzIKAf1cggv8/mm/+uZJ82g5OYH0O7TJJlAUJ4ju
         Fk2QmMJ3nEuVGA0XEkWGWTtlFwPfNmUGW2SmiMbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.7 004/204] PCI: hotplug: ACPI: Fix context refcounting in acpiphp_grab_context()
Date:   Thu, 20 Aug 2020 11:18:21 +0200
Message-Id: <20200820091606.425774608@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit dae68d7fd4930315389117e9da35b763f12238f9 upstream.

If context is not NULL in acpiphp_grab_context(), but the
is_going_away flag is set for the device's parent, the reference
counter of the context needs to be decremented before returning
NULL or the context will never be freed, so make that happen.

Fixes: edf5bf34d408 ("ACPI / dock: Use callback pointers from devices' ACPI hotplug contexts")
Reported-by: Vasily Averin <vvs@virtuozzo.com>
Cc: 3.15+ <stable@vger.kernel.org> # 3.15+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/hotplug/acpiphp_glue.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -122,13 +122,21 @@ static struct acpiphp_context *acpiphp_g
 	struct acpiphp_context *context;
 
 	acpi_lock_hp_context();
+
 	context = acpiphp_get_context(adev);
-	if (!context || context->func.parent->is_going_away) {
-		acpi_unlock_hp_context();
-		return NULL;
+	if (!context)
+		goto unlock;
+
+	if (context->func.parent->is_going_away) {
+		acpiphp_put_context(context);
+		context = NULL;
+		goto unlock;
 	}
+
 	get_bridge(context->func.parent);
 	acpiphp_put_context(context);
+
+unlock:
 	acpi_unlock_hp_context();
 	return context;
 }


