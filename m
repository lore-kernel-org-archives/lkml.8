Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525DBC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2273D20656
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzF1R5W8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgBJSg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:36:29 -0500
Received: from mail-pj1-f46.google.com ([209.85.216.46]:36382 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBJSg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:36:27 -0500
Received: by mail-pj1-f46.google.com with SMTP id gv17so119608pjb.1;
        Mon, 10 Feb 2020 10:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TGovp5+mlZOcilFelIZAYHcz5dqg4ID3OAhR8cryaZc=;
        b=TzF1R5W827UBKMgaeJW2wS/jV1wxHvSaD09AgiWXsI63/lGrUwyz3NXwJGlY+5IRnE
         TSU6/TtroJDywE5DJPQv8GE4j8Fp3LT6jOvjBCowav5A0K1aR0UqDP6oShTlxu5WVavI
         gGmLMKrCTTptTBs9DtHyI92XaCd6yrc/4D7JAdW5kBlJ4YItA/Zi/h+UisxyAKPyb2Zq
         lath+zxBVrci+L/H7IVXkgCl1f7XPmigsCW3nZhrSIgglwKeo62OdtBgvFK/VPuF13st
         vm7rhONFuMqUtcs9H8couOsFq2CUv1awWp/Gm8oodVVGMTcMHTW2CUB5l3a2X7Bt9L7+
         s7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TGovp5+mlZOcilFelIZAYHcz5dqg4ID3OAhR8cryaZc=;
        b=Lwg3XweDuxTfvfYOkZjKIm5UJ+STTVnOO4SLg4cGuE84lEjRY/pSA4T5vk+/hT+hQb
         pWqUH1CIvFw1IczHdKuzpO7kniZqwop45LaAd85YOKbNkLUfIxPu5UYvKxvmtKft7/HH
         BD3EYa6QbY44w/DHInulga5aK/ynw6ZjL+vXKEjGdyzwb1g/7oalu6/JTx7B0j+3aJsC
         GBFsixOmsw+nRMKgRpG4+mbe+rbH6YZBWRj7YhJW4y9pXGLcUY3FVvSKvDaMNmvAKwH4
         WTTk1HJ2mdh8RFizELDn+jWA9j/rmlFfhlK8H05m/cZireKuc9UfFIVlw4iOdG7eow6u
         fb2A==
X-Gm-Message-State: APjAAAUo+8DR+H+wzcnBBVH0ZkFoaaL7CE8q1MSnJQlgylzYOSelI1ej
        RR65bFvwNcoC1T/3VlweGGlFrGeybxc=
X-Google-Smtp-Source: APXvYqzfovHWYqXa5ytLSEwg1TcHjkmWIvcU/eg55j/XQ0jyFbelt+aqSD6th0kZfOH1Xl3C2dU46Q==
X-Received: by 2002:a17:902:aa45:: with SMTP id c5mr13771719plr.113.1581359787196;
        Mon, 10 Feb 2020 10:36:27 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:36:26 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 00/19] Renaming some identifiers. 
Date:   Tue, 11 Feb 2020 00:05:39 +0530
Message-Id: <20200210183558.11836-1-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207094612.GA562325@kroah.com>
References: <20200207094612.GA562325@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset renames following nineteen variables in exfat.h
Fix checkpatch warning: Avoid CamelCase
 -Year->year
 -Day->day
 -Hour->hour
 -Minute->minute
 -Second->second
 -Millisecond->millisecond
 -FatType->fat_type
 -ClusterSize->cluster_size
 -NumClusters->num_clusters
 -FreeClusters->free_clusters
 -UsedClusters->used_clusters
 -Name->name
 -ShortName->short_name
 -Attr->attr
 -NumSubdirs->num_subdirs
 -CreateTimestamp->create_timestamp
 -ModifyTimestamp->modify_timestamp
 -AccessTimestamp->access_timestamp

v2:
 -Correct misplaced quatation character in subject line(s).
 -Remove unnecessary '_'(underscore) character in renaming of identifier
  MilliSecond.
 -Drop commits renaming unused structure members.


Pragat Pandya (19):
  staging: exfat: Rename variable 'Year' to 'year'
  staging: exfat: Rename variable 'Month' to 'month'
  staging: exfat: Rename variable 'Day' to 'day'
  staging: exfat: Rename variable 'Hour' to 'hour'
  staging: exfat: Rename variable 'Minute' to 'minute'
  staging: exfat: Rename variable 'Second' to 'second'
  staging: exfat: Rename variable 'MilliSecond' to 'millisecond'
  staging: exfat: Rename variable 'FatType' to 'fat_type'
  staging: exfat: Rename variable 'ClusterSize' to 'cluster_size'
  staging: exfat: Rename variable 'NumClusters' to 'num_clusters'
  staging: exfat: Rename variable 'FreeClusters' to 'free_clusters'
  staging: exfat: Rename variable 'UsedClusters' to 'used_clusters'
  staging: exfat: Rename variable 'Name' to 'name'
  staging: exfat: Rename variable 'ShortName' to 'short_name'
  staging: exfat: Rename variable 'Attr' to 'attr'
  staging: exfat: Rename variable 'NumSubdirs' to 'num_subdirs'
  staging: exfat: Rename variable 'CreateTimestamp' to
    'create_timestamp'
  staging: exfat: Rename variable 'ModifyTimestamp' to
    'modify_timestamp'
  staging: exfat: Rename variable 'AccessTimestamp' to
    'access_timestamp'

 drivers/staging/exfat/exfat.h       |  38 ++---
 drivers/staging/exfat/exfat_super.c | 232 ++++++++++++++--------------
 2 files changed, 135 insertions(+), 135 deletions(-)

-- 
2.17.1

