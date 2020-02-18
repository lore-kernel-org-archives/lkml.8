Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED78FC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B943A2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056103;
	bh=5BanddPanjla8ZTGWbfTE9JVb11UW/XRK0aZm0tPR+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ciFI/I+0t/SqLMcU1+tUy7K/wZd7Fxmnw0GcUiQKzVlqHiECOq3JtTSVBzsXvetLC
	 1V3EfauXQyEfxtMKOcwcFD2OuNQHxkh0YFi1C4CGl9EDeDptuUOt+GHaJdc/39R5qW
	 giXmG2DWFN8Eg2V5G4o4qu5dN4TI+MGAIxDzTX3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgBRUBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:01:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbgBRUBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:01:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C534124125;
        Tue, 18 Feb 2020 20:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056097;
        bh=5BanddPanjla8ZTGWbfTE9JVb11UW/XRK0aZm0tPR+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryPhAO3Cm8I1osMNpTkv3Grlo6bvhL/wwMNOMzkFNcGSa7vKMciRlypxlCB57Lxoe
         sCR4FPcz8FmvSnhhnb4x1UhgDudqVcnxb+EpyylhYSIWKH9fXYUp9MejCixsvJm+eB
         2FLLi6iq7PW/MUkdeJmLE5Ae5i8rLD8B8E0hV66c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gaurav Agrawal <agrawalgaurav@gnome.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.5 04/80] Input: synaptics - enable SMBus on ThinkPad L470
Date:   Tue, 18 Feb 2020 20:54:25 +0100
Message-Id: <20200218190432.472014867@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190432.043414522@linuxfoundation.org>
References: <20200218190432.043414522@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaurav Agrawal <agrawalgaurav@gnome.org>

commit b8a3d819f872e0a3a0a6db0dbbcd48071042fb98 upstream.

Add touchpad LEN2044 to the list, as it is capable of working with
psmouse.synaptics_intertouch=1

Signed-off-by: Gaurav Agrawal <agrawalgaurav@gnome.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/CADdtggVzVJq5gGNmFhKSz2MBwjTpdN5YVOdr4D3Hkkv=KZRc9g@mail.gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/synaptics.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -180,6 +180,7 @@ static const char * const smbus_pnp_ids[
 	"LEN0097", /* X280 -> ALPS trackpoint */
 	"LEN009b", /* T580 */
 	"LEN200f", /* T450s */
+	"LEN2044", /* L470  */
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
 	"SYN3052", /* HP EliteBook 840 G4 */


