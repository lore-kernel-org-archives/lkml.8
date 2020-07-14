Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E39C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D953720EDD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj7MOBP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgGNJlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgGNJlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:41:45 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4AEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 02:41:44 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a21so670150ejj.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t1goKmWs8WiSF1nT1eZt9VQtP+wqANJIMbkSLOmzlPQ=;
        b=Lj7MOBP1AU6sec/aLVxEwKwFNHW1+LgfjNd1gHtD5gj3aYl86ve5a5wgv1mwZUp0H9
         ljEPVpeZChpI1ATeOu4SDEAtW+B9Qbf03GfbWiwbPB6G0vaQXaIdPSKaFpmVW5poCs7C
         EHSL2Q4E5taLV3/3/5YqegTuhmroBibSlydMo5obrYbqm/dVtrAMWSz56HTPSqnCc5hB
         q/xePnzX0V91pjXFZ8pb9VbLqRBg5yk0oiRJJ0AkNNVOVJthZwhTNR0A8mj8TTbw5ygt
         iJ5f8O84EVlziJ7MdZmdkRRBRNKU14Fb76/8naQiTA6UCQyD6NVkvXv5WZNPpzUCyPb7
         oYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t1goKmWs8WiSF1nT1eZt9VQtP+wqANJIMbkSLOmzlPQ=;
        b=G9GqbJ5EdU6SQutT2gOkjfniUd9yxo1dTrJPHpEyDShVW51OyVYbR6Md0wrqosu7V1
         QGSwEtxhX9eICAW1Z03+NGFaosCY6GpclXsjWHRHmgcc2q/xpOFVfcf1ZSGCECDG93Vu
         wXfQJlR2FM9Y27dXhZ+lfj+Cf5awxIzkiqUZBo8VrDxQq9xLx4FALX7rtOUG2KIJYw52
         sv6qU9oUZCrT3rcatW2IoxuhwMcwBOr7J5w8RkGQgSx1vhoeaIaP6UhDH0m2xLw+RgWE
         4oGzFEmtUnlPcy3JzpMM0RKLOgahPavkudXDe1SC8hbEkPt62PpKvXcOqzI9Y2QbKzlD
         37Ww==
X-Gm-Message-State: AOAM533wrapaKHVA2rhz5FkYt3IYT7fY4DOl6nTtJf02DgkGj7pgYUiM
        x0aPg4Jo7557jLL1c6lzjPw=
X-Google-Smtp-Source: ABdhPJzbHyXdOB+4r2vLVBSv+RpNvQdu/saLh4j/ZuePIca6/mGkdLW6cXaTsWHJzjqV7Xv/jXVqqA==
X-Received: by 2002:a17:906:4341:: with SMTP id z1mr3638997ejm.392.1594719703396;
        Tue, 14 Jul 2020 02:41:43 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id cw14sm14077959edb.88.2020.07.14.02.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 02:41:42 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch.pl: Allow '+' in compatible strings
Date:   Tue, 14 Jul 2020 11:41:41 +0200
Message-Id: <20200714094141.147418-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The current checks will interpret a '+' character as special because
they use regular expression matching. Escape the '+' character if it
appears in a compatible string.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4c820607540b..8104d0736e7f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3145,6 +3145,7 @@ sub process {
 			my $vp_file = $dt_path . "vendor-prefixes.yaml";
 
 			foreach my $compat (@compats) {
+				$compat =~ s/\+/\\+/;
 				my $compat2 = $compat;
 				$compat2 =~ s/\,[a-zA-Z0-9]*\-/\,<\.\*>\-/;
 				my $compat3 = $compat;
-- 
2.27.0

