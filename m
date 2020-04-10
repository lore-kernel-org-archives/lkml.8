Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D42C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A313C2078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffZOsTYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgDJQ6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:58:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35985 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 12:58:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id u13so2428338wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 09:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Zm05jd4ot0twDY3U5DXhTVZzlsMPv7YB8r5JVuqwQjg=;
        b=ffZOsTYGz/StbWDLUX0KA2AQwF8oHIZNK9OCUV3Hi3cSqeu8+4ozvFAzBItDez1BCS
         z9+Q6pTm9RbfdD9R1S2GdHjAD4/Htv7w1z8SMqAP+U4cju8GmBlU/t8vOCIV0GBe8Zgt
         Si5XWr68lO9U9RARDidTtfaPlRXMoIfbJKXgxRbPPn070P/mR6pU/87St5VVuDbWjwlj
         oFdwL5iC2PuRhvvdNer7N328Ub4wx5ldnQq7fNeyZ+9g3bnAupa01rOpm5+ckMV7Ga5Q
         90YW76TpzWn3RPVNlZDwG95pTq8Uv3m9eJDs4nSq3FOPTEj503zXOAI/U9kOFUgmIaZ4
         Owzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zm05jd4ot0twDY3U5DXhTVZzlsMPv7YB8r5JVuqwQjg=;
        b=P+9l09gM5ptre9qnj1WGbc8keKyplZXH2M4bmuZ8IBfq7wb8cKSc95Pwa2xN8OCGv3
         CU6/9NfakX6UwfzyShAPhmcg9WeK+956MeNjybj3Nbpez8WK+hcWoSANlpqQhu0wh72Y
         CEfRvow1/786BCNkkxyKmLq3FWkdLSnDPMGDdDYBEZ8GF12WPbUnknnfN91vP5kY9nL3
         F/5eUPVrcd75g1V0AGVdGGnD9kP26GXND4xN7Z7xOmY4SSPkRPUXhxPfRB7A57UV9Y5T
         r+XPicZw9gN8w57k6C2Wh00G67i99GrdYgioi31vRnOq4GAHMUAZP1LJSXyk4xkvULWM
         EKEA==
X-Gm-Message-State: AGi0PuY+7Aqf/vU8m8w0BzrN48CJTvYxYYgqaUfQrUQfaZULBJuwfyZo
        L/XJn+TTh6J8yuv/Z5DHCraY45Si3vM=
X-Google-Smtp-Source: APiQypJMja2F44giBKNUW30QzuB9XjIVxLOR3Fk2Hdoz2b3uEFN39IZZ5XD2IK2fhFVATq2hFgrDKQ==
X-Received: by 2002:adf:ec50:: with SMTP id w16mr5743042wrn.95.1586537924222;
        Fri, 10 Apr 2020 09:58:44 -0700 (PDT)
Received: from alpha.lan (176-149-93-98.abo.bbox.fr. [176.149.93.98])
        by smtp.googlemail.com with ESMTPSA id a15sm3423008wme.17.2020.04.10.09.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 09:58:43 -0700 (PDT)
From:   "Jeremie Francois (on alpha)" <jeremie.francois@gmail.com>
Cc:     "Jeremie Francois (on alpha)" <jeremie.francois@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/config: allow colons in option strings for sed
Date:   Fri, 10 Apr 2020 18:57:40 +0200
Message-Id: <20200410165741.27078-1-jeremie.francois@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sed broke on some strings as it used colon as a separator.
I made it more robust by using \001, which is legit POSIX AFAIK.

E.g. ./config --set-str CONFIG_USBNET_DEVADDR "de:ad:be:ef:00:01"
failed with: sed: -e expression #1, char 55: unknown option to `s'

Signed-off-by: Jeremie Francois (on alpha) <jeremie.francois@gmail.com>
---
 scripts/config | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/config b/scripts/config
index e0e39826dae9..d365081b60b2 100755
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
2.17.1

