Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B3DC35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 01:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85BC20722
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 01:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/G2izCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgBVBk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 20:40:58 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:58267 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgBVBk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 20:40:56 -0500
Received: by mail-pj1-f74.google.com with SMTP id ca1so1990397pjb.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 17:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dLJUCpK8J7QSv9pjJWTn5rjODL1aEvnJG2mu5Q6XKZg=;
        b=e/G2izCtRWiEex8vSlfihQZwWbRD38v38ILG4l4r0PBFW4nViuSsYy2XUvAta7Lg+H
         iwqAKMJhoSdeJvTXWCRNXcpv/oibXCTVqKiCZAtcZ/10EL22JqVpY311ZGjdWeCZ6TWl
         8dyvPrRs3TcgxxUs+km0ytcbrL8LP1G4CqJEc+oX/d3UX0nhbrwIbgTzLHjrUY9Qv0iT
         vMKmD8aus0eCRycaqJkgLLOPimbsn9TPbDIsjZfKcyaWKw7f7WfeukqDuKNG4mncrK8V
         XMYT45YusmnMzgHTM21b3xNOrzprNYN46RRF/MK+TTqfmcgndJlUtph86LKTOtFenFaQ
         uNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dLJUCpK8J7QSv9pjJWTn5rjODL1aEvnJG2mu5Q6XKZg=;
        b=mRuBWq8tE1OJy6Rl9exSHScMgJtkx85dryjqZsK3FEjlZGUG71R7HzD0suC57dB2XN
         AC2r+++/Cv+EYT+I3zxLnFuz+co/wlFk4+ousYE4rkJDJgVMrSTGA4HsormxP1VSC6qj
         Gt3IYQ+li24/IBcL81pDgLclXWhZq8WxKDHGpU8jh87cX4UYFuY6WfHijB7bOAqXF0IR
         zC4cQqnDteRjqmZcIDK67c+8HISOv66yoqy7F/iuVsViGpAZwHn95hRTD/nn5BAX5dve
         pszkavERogIn2rZMbqx6gUhizllT9DN7NR67+9Bqt4rHQaagxmZi/VFK0N/159blFJUk
         VLvw==
X-Gm-Message-State: APjAAAUH6NFBAln6vi+1e8/DLjazx5il2KqPg1mKAkF6HogvPdBGsv/Q
        ggd75GyZ73VKgi8MnHO1qtbnmuRqrG8wv/A=
X-Google-Smtp-Source: APXvYqzesfXR7lGxs6e5jxSQUmuI+4SNQj8u282WnFoEoOOntmofH4HAOCXHvIB2dz4XXYHvKMvIdKicGMtW4q8=
X-Received: by 2002:a63:be48:: with SMTP id g8mr42416014pgo.23.1582335655195;
 Fri, 21 Feb 2020 17:40:55 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:40:37 -0800
In-Reply-To: <20200222014038.180923-1-saravanak@google.com>
Message-Id: <20200222014038.180923-5-saravanak@google.com>
Mime-Version: 1.0
References: <20200222014038.180923-1-saravanak@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v1 4/5] of: property: Start using fw_devlink_get_flags()
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fw_devlink_get_flags() provides the right flags to use when creating
mandatory device links derived from information provided by the
firmware. So, use that.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index e851c57a15b0..15fc9315f1a7 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1262,7 +1262,7 @@ static int of_link_property(struct device *dev, struct device_node *con_np,
 	u32 dl_flags;
 
 	if (dev->of_node == con_np)
-		dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
+		dl_flags = fw_devlink_get_flags();
 	else
 		dl_flags = DL_FLAG_SYNC_STATE_ONLY;
 
-- 
2.25.0.265.gbab2e86ba0-goog

