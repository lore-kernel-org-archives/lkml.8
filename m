Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D876C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C7824676
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH2keU2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgCBScH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:32:07 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:37176 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBScH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:32:07 -0500
Received: by mail-pl1-f182.google.com with SMTP id q4so121133pls.4;
        Mon, 02 Mar 2020 10:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0dlUWrrxGVbo8SmkPvRn4Zf/awc4GBKqMK3utL1xud0=;
        b=HH2keU2dvU+0B47EQMgF/EsH+A4fh5zWT/BxUT6/tUqSlnQ/fkWDW5ukS5IT5IVm7S
         zhtTH3nZlItKMXf6tyQ/SVDUiq2Eo8DhOMSmBkdkiQt/jQMKdyUSv7rp9cG0XJTqhEoE
         Rk7UWR1GfKdd9i3OP6Xe3w3CKioPAVu1dHfwnG1YlIo6Q4F/APGcv0LaDZYJU+9Sk0pf
         COn7W/fU2XDC6e+J8ePcDRJ7JnTdgGQuSAiceV0KnwOwSXh2CtGWYqDtAoI72gVtN48l
         69wdNeVX/xFGnKbGbfqb/AezVZutwKPkp5muugsLVYbx2IT2ighCKxkQ1LWWk4TnD04s
         FX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0dlUWrrxGVbo8SmkPvRn4Zf/awc4GBKqMK3utL1xud0=;
        b=R8jnAaN/so3z1bZk47pcbAFA8vtR6ca+4YzzFEggnu2uGdEQ7K+YG58X6W+VMfmYpj
         IwczQeCB6ddh3cWVjqOkjSVuL0mqs13skmyx/BNeO1Ct+QPK5Kqi/G3txfPnS3VDYAVG
         +5tA1l5pbKT/oZ+ILfZZXZIXYezoGIVoXsQbnrc2sUreHZr+EQmJFkXyNIQy0MLwZNfP
         4FODRdkpt8V3XBwKiHwtQmC6IUjbEZ1A+HM7/1V2BAuLhDB/jyLfFMmRhWYEyTFygwEU
         lJvQOCSbbuLf0m6P2WhJYqKCfcp5hPMMTt6T/VT4w9gtRHqTO01DL1PI6c8uEjReGwHA
         okig==
X-Gm-Message-State: ANhLgQ3xk/MYJgKrVN4FEnEUHsejvTuPRDhWh5HEB5hi7tv4SALx0V2M
        RhngA+f2Tj/IWSuqbd5NAy/H4QjKII1hXA==
X-Google-Smtp-Source: ADFU+vtH0oXhjTF9jRR8Zp7mxCpWPabhmAdSYWB4x8/SP/8jQpSD/AUYV277LKqnORmB0s2qYIc8VA==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr318072plb.121.1583173925861;
        Mon, 02 Mar 2020 10:32:05 -0800 (PST)
Received: from localhost.localdomain ([2405:204:800a:15c3:b0b0:78ba:d728:349e])
        by smtp.gmail.com with ESMTPSA id r145sm22508484pfr.5.2020.03.02.10.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 10:32:05 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 0/2] Documentation: Add files to driver-api manual 
Date:   Tue,  3 Mar 2020 00:01:03 +0530
Message-Id: <20200302183105.27628-1-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302104501.0f9987bb@lwn.net>
References: <20200302104501.0f9987bb@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds following two rst files under
Documentation/driver-api and references these both in Sphinx TOC Tree in
Documentation/driver-api/index.rst
 -io-mapping.rst
 -io_ordering.rst

v2: 
 -Provide more descriptive subject lines
 -The document did not belong to top level so moved it to driver-api
  manual

Pragat Pandya (2):
  Documentation: Add io-mapping.rst to driver-api manual
  Documentation: Add io_ordering.rst to driver-api manual

 Documentation/driver-api/index.rst       |  2 +
 Documentation/driver-api/io-mapping.rst  | 97 ++++++++++++++++++++++++
 Documentation/driver-api/io_ordering.rst | 51 +++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 Documentation/driver-api/io-mapping.rst
 create mode 100644 Documentation/driver-api/io_ordering.rst

-- 
2.17.1

