Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A03C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6D12063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255500;
	bh=xUP8nxxbfEiFVfmUm/ZNgJa028UtvfzI9OYN6ITAbVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sMwqdQVgYOTaoIz8rBdHgVQuwAyQZs4SlVDTqFRxDKS0W9iLr6OPVT2K9geT4COfw
	 IBg85Ign0Clg977mqZUPvMSA5RlenwPP1wdWJoSuW9xIgnS6VtQ6PK5UTQ/BLim6bb
	 0tJFck73ylMeX6deeE2+aXM053hT/Smc7xwXH4/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgD3OE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbgD3NxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:53:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B4E24959;
        Thu, 30 Apr 2020 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254787;
        bh=xUP8nxxbfEiFVfmUm/ZNgJa028UtvfzI9OYN6ITAbVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w1c91Srg5MJOQh+DNkVI6dzuZeY4MbGeIpeQlvB1Q99cw6xUw4WgEhUWo+th3mvLa
         DKCqCZxWrk5BbG+sWq4oYPIHAu4ieL1Y/PM8eg0qLtQ+vNeRhdGHbh6WiFFaqUzZ19
         5MxepPPaEPDh9ClLCkYbkhCeGFH3L0Y8tzCFFKrk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Jeremie Francois (on alpha)" <jeremie.francois@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 43/57] scripts/config: allow colons in option strings for sed
Date:   Thu, 30 Apr 2020 09:52:04 -0400
Message-Id: <20200430135218.20372-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135218.20372-1-sashal@kernel.org>
References: <20200430135218.20372-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jeremie Francois (on alpha)" <jeremie.francois@gmail.com>

[ Upstream commit e461bc9f9ab105637b86065d24b0b83f182d477c ]

Sed broke on some strings as it used colon as a separator.
I made it more robust by using \001, which is legit POSIX AFAIK.

E.g. ./config --set-str CONFIG_USBNET_DEVADDR "de:ad:be:ef:00:01"
failed with: sed: -e expression #1, char 55: unknown option to `s'

Signed-off-by: Jeremie Francois (on alpha) <jeremie.francois@gmail.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/config | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/config b/scripts/config
index e0e39826dae90..eee5b7f3a092a 100755
--- a/scripts/config
+++ b/scripts/config
@@ -7,6 +7,9 @@ myname=${0##*/}
 # If no prefix forced, use the default CONFIG_
 CONFIG_="${CONFIG_-CONFIG_}"
 
+# We use an uncommon delimiter for sed substitutions
+SED_DELIM=$(echo -en "\001")
+
 usage() {
 	cat >&2 <<EOL
 Manipulate options in a .config file from the command line.
@@ -83,7 +86,7 @@ txt_subst() {
 	local infile="$3"
 	local tmpfile="$infile.swp"
 
-	sed -e "s:$before:$after:" "$infile" >"$tmpfile"
+	sed -e "s$SED_DELIM$before$SED_DELIM$after$SED_DELIM" "$infile" >"$tmpfile"
 	# replace original file with the edited one
 	mv "$tmpfile" "$infile"
 }
-- 
2.20.1

