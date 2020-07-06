Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34709C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1369420715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xms4RpfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgGFK50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbgGFK5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:57:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83978C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 03:57:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j4so37896848wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 03:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2xHtBHyIdQ09rBCcIyd7tye4mkZ083sSa8R65WPM6ik=;
        b=Xms4RpfMkjhJc7D8kwKPgwx4G5N19R98AoxpqxGwiBZ6RWbt4d8AnYeGbLZY0iKqJH
         aBTd+wessxMey0FzXsf5csNYsrNn62EkAJ4lXrRyYYO2C+DSg37EjeY147pRVMA5IrZ/
         yLAjsWd1MgRwJ6tJLnurROu9H8LMjsJMnc+3ZFGUOB12XFhHHTmQBMW6lgNBB+JTs3RS
         C9Wd5i62xZ4ztHD2VPXZ3R6UiBOJViaN9ZUySLL8hLm9Ax0bA+kkvpoUFGprjpvlWqpo
         YK16cFQjxmPu3VwF9azUBucYCAh/t/ZUY3LXgvj7tjOd6mDCQIj25sp/yMgydnEhVUtt
         4tqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2xHtBHyIdQ09rBCcIyd7tye4mkZ083sSa8R65WPM6ik=;
        b=HCmKRPc1OCWHxw+5raf8AVJpideno/Ui/NqE2NnxAQpgYFUtmaIAXyqJJATwQw2tVd
         L1zfz4SAUdDfXZs4l6nrTrxIksTv+lfg65N2DtGW/0PsaEkDZwdpzXLApdDIJYdLmSJC
         vjI22uxigQUM1MJXQLBzbIeGE9GssKh96+o7eOuGl8TN1f+7EVnGRrdB96acwcrdQhua
         WDXZhFRLlmlDmt+quzgScNv7/75PS09ZUX9827ApSzJ99yFNbxVSnnqm5aDxwsCvA16v
         UHyy6MrwxwsLhwKabWy1sFEvwoCLOoh75iounQTpZL5T14LRMjlnPWEWMQP5xd4aG2yO
         P9FA==
X-Gm-Message-State: AOAM530ohUPaSgdHOz1g2Np7dI6ddX3DhTbMflzXqPDYP/IMngsT2hlA
        QZmDzYI8Ji3Nh2X6Tc+JEFy3Zwr7bQU=
X-Google-Smtp-Source: ABdhPJzjxTg2X3+vtJvThPO/bnKqtA7sawY2jecA7IDNlXh6vLpq3o7quoiZpmnTLTNKGoCXwiefvQ==
X-Received: by 2002:a5d:55cf:: with SMTP id i15mr52382081wrw.204.1594033044031;
        Mon, 06 Jul 2020 03:57:24 -0700 (PDT)
Received: from maphy.uni-hannover.de ([130.75.75.70])
        by smtp.gmail.com with ESMTPSA id o21sm5637464wmh.18.2020.07.06.03.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:57:23 -0700 (PDT)
Date:   Mon, 6 Jul 2020 12:57:22 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v3 0/6] vt: Add SRG mouse reporting features
Message-ID: <cover.1594032517.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

this patchset adds xterm like mouse reporting features to the console.

The linux virtual console has support for mouse reporting since 1994 or so,
but the kernel only supports the original X10/X11 style standard protocols.
To support more protocols these patches expand the kernel structures in a
up- and downwards compatible way, see the last patch for detailed
documentation and pointers to even more detailed docs.

The main goal is to become compatible with xterm, as most TUI software today
is tested in xterm or another compatible terminal.

Support by the mouse daemons (consolation, gpm) will be needed too.


Kind regards,
Tammo

Changes from v2:
- Rename enum and and use it as a type for vc_protocol_mouse
- Correct cding style and new spelling error

Changes from v1:
- Really fixed the style und spelling errors (Sorry Randy!)
- Created defines and enums for better readability
- Made variable to store last pressed button static and moved into
  mouse_report function  

Changes from v0:
- Fixed al the style the things mentioned by Jiri and Randy (thanks!)
- Change datastructure for report (better compatibility)
- Changed documentation in large parts accordingly
- Added URXVT protocol

Tammo Block (6):
  tiocl.h: Change/Add defines for mouse report
  console_struct.h: Add members for mouse report
  vt/vt: Enable mode change via escape sequence
  vt/vt: Add SRG mouse reporting protocol
  vt/vt: Add URXVT mouse reporting protocol
  Documentation: Describe console mouse reporting

 .../admin-guide/console-mouse-reporting.rst   | 88 +++++++++++++++++++
 Documentation/admin-guide/index.rst           |  1 +
 drivers/tty/vt/vt.c                           | 45 ++++++++--
 include/linux/console_struct.h                |  9 +-
 include/uapi/linux/tiocl.h                    |  8 +-
 5 files changed, 143 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/admin-guide/console-mouse-reporting.rst

-- 
2.27.0

