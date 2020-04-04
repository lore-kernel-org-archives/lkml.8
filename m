Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61743C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 03:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254C1206CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 03:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AQ5FJpw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgDDDbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 23:31:22 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54068 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgDDDbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 23:31:22 -0400
Received: by mail-pj1-f68.google.com with SMTP id l36so3954553pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 20:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yb4sedJ2tzSSP8vY8CJn4oOdCuDLhyqm+zlcvBw3DBQ=;
        b=AQ5FJpw6q48mmbQFY8ofZDCCQshBDmeQhvDOa2gWUZv/ZlQYcvVe6PMwj8oidgVV1l
         yHXi7RCzKvF/LOF0cV3z9jeiNNxk5KnRhyhqBnJN04yHXTltDeuNF/m4XG8PpfbkrOw+
         qIDO61A25AGrigWpNrzmZ8iAfLDtcKv5ZvtKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yb4sedJ2tzSSP8vY8CJn4oOdCuDLhyqm+zlcvBw3DBQ=;
        b=UfqUv3YHUGmgapIB3hLv+kO6GLLk/CeTXOd5SgQ5k7BHA2Zc/Var96gq77rAUljatC
         TSimTXjX3EvlX29FS4oD8TEUiz3Gl0837U5lKv2YDW2OiAsjfmS/nMiX0w+TbfFFjqD8
         T7j6w0NaTJSaslA5u1j/ScImpGukfvHN71zGqpIOhOtYxhn39eqGIbRyJu1O2oSYjxoJ
         Wq5Bgy7Mc/po3nyAALTpZxF7NtcsZlLRpv1EVe9Y4G9oeBPP6rdWdd3kKCBHFDLYLqPp
         OF4NhZVJeI0htsjJi54k6j+e25HA9fYWv+FWh7Z7dp9nyPYbFsISaziooohSZWOemnWC
         DvXw==
X-Gm-Message-State: AGi0Pua0XmaywsJSi1qf4jCbJ8GgQhKbybbE2u8RQPLywl65VJQ6ZCJq
        J7P9k3WjxDxUDqIX4txQ3EAoZQ==
X-Google-Smtp-Source: APiQypK+NiPoIMeIrGBVzUqIrPu1rjThSOe/mtbsKja7a5gz0wCbtzBRy5rEDAJQ/IlxyEdHatE99w==
X-Received: by 2002:a17:902:6b84:: with SMTP id p4mr10309683plk.15.1585971081656;
        Fri, 03 Apr 2020 20:31:21 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id o184sm6800599pfg.149.2020.04.03.20.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 20:31:20 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v5 0/3] btusb: Introduce the use of vendor extension(s)
Date:   Fri,  3 Apr 2020 20:31:15 -0700
Message-Id: <20200404033118.22135-1-mcchou@chromium.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel and Luiz,

The standard HCI does not provide commands/events regarding to
advertisement monitoring with content filter while there are few vendors
providing this feature. Chrome OS BT would like to introduce the use of
vendor specific features where Microsoft vendor extension is targeted at
this moment.

Chrome OS BT would like to utilize Microsoft vendor extension's
advertisement monitoring feature which is not yet a part of standard
Bluetooth specification. This series introduces the driver information for
Microsoft vendor extension, and this was verified with kernel 4.4 on Atlas
Chromebook.

Thanks
Miao

Changes in v5:
- Extract the changes on btusb as a different commit.
- Update the include line of msft.h.
- Extract the changes on btusb as a different commit.

Changes in v4:
- Introduce CONFIG_BT_MSFTEXT as a starting point of providing a
framework to use Microsoft extension
- Create include/net/bluetooth/msft.h and net/bluetooth/msft.c to
facilitate functions of Microsoft extension.
- Move MSFT's do_open() and do_close() from net/bluetooth/hci_core.c to
net/bluetooth/msft.c.
- Other than msft opcode, define struct msft_data to host the rest of
information of Microsoft extension and leave a void* pointing to a
msft_data in struct hci_dev.
- Introduce CONFIG_BT_MSFTEXT as a starting point of providing a
framework to use Microsoft extension
- Create include/net/bluetooth/msft.h and net/bluetooth/msft.c to
facilitate functions of Microsoft extension.

Changes in v3:
- Create net/bluetooth/msft.c with struct msft_vnd_ext defined internally
and change the hdev->msft_ext field to void*.
- Define and expose msft_vnd_ext_set_opcode() for btusb use.
- Init hdev->msft_ext in hci_alloc_dev() and deinit it in hci_free_dev().
- Introduce msft_vnd_ext_do_open() and msft_vnd_ext_do_close().
- Create net/bluetooth/msft.c with struct msft_vnd_ext defined internally
and change the hdev->msft_ext field to void*.
- Define and expose msft_vnd_ext_set_opcode() for btusb use.
- Init hdev->msft_ext in hci_alloc_dev() and deinit it in hci_free_dev().

Changes in v2:
- Define struct msft_vnd_ext and add a field of this type to struct
hci_dev to facilitate the support of Microsoft vendor extension.
- Issue a HCI_VS_MSFT_Read_Supported_Features command with
__hci_cmd_sync() instead of constructing a request.
- Define struct msft_vnd_ext and add a field of this type to struct
hci_dev to facilitate the support of Microsoft vendor extension.

Miao-chen Chou (3):
  Bluetooth: Add the framework of using Microsoft vendor extension
  Bluetooth: Read the supported features of Microsoft vendor extension
  Bluetooth: btusb: Indicate Microsoft vendor extension for Intel
    9160/9260

 drivers/bluetooth/btusb.c        |  11 ++-
 include/net/bluetooth/hci_core.h |   5 ++
 include/net/bluetooth/msft.h     |  26 ++++++
 net/bluetooth/Kconfig            |   7 ++
 net/bluetooth/Makefile           |   1 +
 net/bluetooth/hci_core.c         |   5 ++
 net/bluetooth/hci_event.c        |   5 ++
 net/bluetooth/msft.c             | 140 +++++++++++++++++++++++++++++++
 8 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 include/net/bluetooth/msft.h
 create mode 100644 net/bluetooth/msft.c

-- 
2.24.1

