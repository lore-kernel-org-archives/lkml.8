Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3444AC3F2D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0052B20873
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6sbGcJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgCCFDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 00:03:24 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:39629 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgCCFDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 00:03:24 -0500
Received: by mail-pl1-f178.google.com with SMTP id g6so760649plp.6;
        Mon, 02 Mar 2020 21:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eLgz00wfdz9N0jvVCBeUH0wvQLTL+dDy54Z23PzWjAU=;
        b=J6sbGcJlfAGXRutK7hZv/Mk/v2DyZ6unEYLjumIlqSIkE2h27P6IfV0sRkiczbl/tJ
         X5f7xvOlJ56tt3yZktu/vcsGbLIGMFm/NfN479MW9MtWTHcMTNO8GM7vt6oIW1o/Lgow
         TkVo8iYEVq36ADO3nihuNYhMZbDbCed8NvrbUK4yG10g5xg+C3GiX8zv+0SnYzBUn803
         yiY7mbjoVSvg7ds8YzudFE+ilA7nBlVHgbycUxIRWUxH3zSX86Tui9Uve4ONDtljhQk/
         OWXIoxjcLi3F1a0Oc19uHoAh4mWeodHPj7Tpcn/5FZjX3vgeFzW2VcFdQCQEYGtSSats
         kPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eLgz00wfdz9N0jvVCBeUH0wvQLTL+dDy54Z23PzWjAU=;
        b=TU9yBadgaAGfB6DcEYNE3u4fyM+3oVW9dlzWfxWAQqGEk/tSYBVRxfdUtSKWV/mVyQ
         A6JY1dibHty0APCQP5iJIAUfjpWaGAbzWYk06o4eUqm8oIZjw8KnKtu9woS2SPWRgjE4
         YuOFi4kIzt9sdbmTnuOu/QbbsVKW7Grqaz+MURWYN/Ibh/BLDS1ZyIpznz4J/LPnN7hN
         tchQ6afMuTdGZhjwiLt2C+3yH5s4xClPP1Ccb+hBTRNRwCKFlHxqc3btUSUkFMxTBOjd
         AXyejNbhV/fZenjiCTQ12anBblBrYTGB+Aqoe38C0RiB52nWSsLvOPJ1rLnvQRsD3KGS
         kuNA==
X-Gm-Message-State: ANhLgQ2cm9H6da2v/cNeDR1aYdOkiBDwTmkmptIh1nZXTnoP8pbQ4dEY
        u4beqA7/XczlLGIrSRTGNlho4GvNUQ+QzQ==
X-Google-Smtp-Source: ADFU+vs6JQW1Tol+V82s/wT5nWDEySTRxteYJJRYxDhajzZzXu1gPbrUcHkR7StH22DlyZnrd8IxdQ==
X-Received: by 2002:a17:90a:20b:: with SMTP id c11mr2127397pjc.53.1583211801855;
        Mon, 02 Mar 2020 21:03:21 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c8aa:e481:f8d3:6de2:77f9:5602])
        by smtp.gmail.com with ESMTPSA id b2sm780446pjc.40.2020.03.02.21.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 21:03:21 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v3 0/2] Documentation: Rename two txt files to rst
Date:   Tue,  3 Mar 2020 10:32:59 +0530
Message-Id: <20200303050301.5412-1-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302114300.34875f69@lwn.net>
References: <20200302114300.34875f69@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset renames following two txt files to rst files and moves
them to driver-api manual from top level.
 -io-mapping.txt (Documentation/) -> io-mapping.rst(Documentation/driver-api/)
 -io_ordering.txt(Documentation/) -> io_ordering.rst(Documentation/driver-api/)

v2:
 -Provide more descriptive subject lines.
 -Move newly generated(rather renamed) rst files to driver-api manual
  from top level documentation.
v3:
 -In v2, the old files were left in place creating new rst files.
 -Rename the target files rather than simply creating new files.


Pragat Pandya (2):
  Documentation: Add io-mapping.rst to driver-api manual
  Documentation: Add io_ordering.rst to driver-api manual

 Documentation/driver-api/index.rst                            | 2 ++
 Documentation/{io-mapping.txt => driver-api/io-mapping.rst}   | 0
 Documentation/{io_ordering.txt => driver-api/io_ordering.rst} | 0
 3 files changed, 2 insertions(+)
 rename Documentation/{io-mapping.txt => driver-api/io-mapping.rst} (100%)
 rename Documentation/{io_ordering.txt => driver-api/io_ordering.rst} (100%)

-- 
2.17.1

