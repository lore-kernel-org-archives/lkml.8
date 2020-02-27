Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66C1C3F342
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7087224656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813962;
	bh=/W5HUgLROjaLknRqFXz3IQUcQ1wn8g28oMY+0ptuQm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hBFiurhYDU3zUSwmK59y08xuP+bmrRoW4D0vtPtSp0Zb7ijf+YKJ+A/JLcP5OvOuw
	 G8NEDjcYsRzNvL9GLw94rs563XAA0nCx32iJoFu0snH/LFq4s34oNTHPmcaIXRSdcJ
	 Wx8ijrLs8KOMH/uYmJ5M7ISHZ7tYHPxlBnF/aXXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732991AbgB0OBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:01:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbgB0OBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:01:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEDA221556;
        Thu, 27 Feb 2020 14:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812103;
        bh=/W5HUgLROjaLknRqFXz3IQUcQ1wn8g28oMY+0ptuQm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wsF1d04IABVYcC4v5EA18wROyNahjIhDzRzb5QnZh5PVPkcER1qnaUQHjm2W8gXSl
         EStfLuVRZnJOWi9JF55TOLfb++cPQf5bN6Rmxz/0Xwn6IVU2ww1eX0BjjHwz/4lbOf
         3JJRJ6GLnYCf1BMsFSLtLUBtrVtG6MXuJSRTEuuk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.14 196/237] MAINTAINERS: Update drm/i915 bug filing URL
Date:   Thu, 27 Feb 2020 14:36:50 +0100
Message-Id: <20200227132310.724009522@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jani Nikula <jani.nikula@intel.com>

commit 96228b7df33f8eb9006f8ae96949400aed9bd303 upstream.

We've moved from bugzilla to gitlab.

Cc: stable@vger.kernel.org
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200212160434.6437-1-jani.nikula@intel.com
(cherry picked from commit 3a6a4f0810c8ade6f1ff63c34aa9834176b9d88b)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6877,7 +6877,7 @@ M:	Joonas Lahtinen <joonas.lahtinen@linu
 M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
 L:	intel-gfx@lists.freedesktop.org
 W:	https://01.org/linuxgraphics/
-B:	https://01.org/linuxgraphics/documentation/how-report-bugs
+B:	https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bugs
 C:	irc://chat.freenode.net/intel-gfx
 Q:	http://patchwork.freedesktop.org/project/intel-gfx/
 T:	git git://anongit.freedesktop.org/drm-intel


