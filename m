Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BB0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73C420829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spun.io header.i=@spun.io header.b="xEF7JtA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgEROGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:06:45 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:42408 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgEROGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:06:45 -0400
Date:   Mon, 18 May 2020 14:06:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spun.io;
        s=protonmail; t=1589810800;
        bh=+46M3shS9Qa/OOwsn8DgcyOFXKauUYbyDUsb0bgOOuQ=;
        h=Date:To:From:Reply-To:Subject:From;
        b=xEF7JtA4jXLk0OHSYOECUbyleqJS1JhnM/L6nRvftueUD6HB7m8z2jUh6E2OQSirK
         ACY1WmRIEY2r3udbKGdWU6Ukx25ggOQlL+/qewV6b9XzwA3LMprq0PI2hRY99qbTUh
         0ZQgYulwe0FtmepQgSJ45nWOrhMC/e2j7YjYSVXo=
To:     linux-kernel <linux-kernel@vger.kernel.org>
From:   Nick Price <nick@spun.io>
Reply-To: Nick Price <nick@spun.io>
Subject: ixgbe: firmware spam on X520-T2 NIC (82599EB)
Message-ID: <990c978692b74204f7b4d0a2c72f3d0d43b823ea.camel@spun.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ixgbe_main.c around line 7882, the call to ixgbe_check_fw_error
causes spammy messages on certain adapters because the fwsm register
returns 0, triggering the !(fwsm & IXGBE_FWSM_FW_VAL_BIT) condition.

This causes, every two seconds, one error message to be emitted per
interface:

[79062.730890] ixgbe 0000:2a:00.0: Warning firmware error detected
FWSM: 0x00000000
[79062.890877] ixgbe 0000:2a:00.1: Warning firmware error detected
FWSM: 0x00000000
[79064.746743] ixgbe 0000:2a:00.0: Warning firmware error detected
FWSM: 0x00000000
[79064.906728] ixgbe 0000:2a:00.1: Warning firmware error detected
FWSM: 0x00000000

Bit 15 of this register is supposed to be set to 1 upon card
initialization per the Intel 82599 datasheet, however, these particular
cards do not behave per their documentation and there are no firmware
updates available from Intel or Dell that resolve this issue (there
have been firmware updates for other models which have resolved this
problem)

Would it make sense to skip the error message if the entire fwsm
register is zero?  Or maybe only emit it once?

Or do we just continue to spam because technically this *is* a firmware
error although it does not impact functionality and there is seemingly
no resolution on the vendor side.

Anyone have any thoughts? Some references below.

Thanks!
Nick


For reference:
The commit that added this message is at=20
https://github.com/torvalds/linux/commit/59dd45d550c518a2c297b2888f194633cb=
8e5700

More threads on the subject - it seems people are either patching the
kernel to eliminate the check completely or switching to Intel's
driver:
https://bugs.centos.org/view.php?id=3D16495
https://patchwork.criu.org/patch/11882/
https://forum.proxmox.com/threads/pve-6-0-7-ixgbe-firmware-errors.58592/




