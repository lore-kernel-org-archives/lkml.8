Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFFBC3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 17:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4EA20724
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 17:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezvJ9QVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgDRRlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 13:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgDRRlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 13:41:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6960CC061A0C;
        Sat, 18 Apr 2020 10:41:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i10so6767915wrv.10;
        Sat, 18 Apr 2020 10:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=BtWk0TZtC222trolaxncOK7gOtF5nGppvGkqPwi0u3o=;
        b=ezvJ9QVIQPRVAlCmiNU0RksuvcrI9vUHjPcFi92hecKsF2CegsxlC5EVlOBiZ0pekI
         zwTl0sQqgjY2dv7c3ymt/dVtqF9z/mfBavJHXwVZXSNSvRqArohmdCmJyPF3rTt5DG+W
         wDuOqpBFfiyS2qQoMLoksJeGkoDp7ga7xwkmgYepi06N89dN+UlOJa7gkg6oNcm2Kt5q
         DNX0r8GfkEmtvoyOD+tCavtm0K8gEl3VaiUZujftviICROYn7VpMn0v1XScExA2TK8+y
         XqkBdwW8qFj1Bn6IbzBvo63Q80q4785JxyEmL2QSAErkNXHlqbqBp0ww1NCKt+eU855s
         ADsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=BtWk0TZtC222trolaxncOK7gOtF5nGppvGkqPwi0u3o=;
        b=cxu0MbNOKwEllt6GRWZaRsKSdKKP+IdmV4yP8urE/na55Ld3JLzX0QUQ71P9UEcLfC
         6xXio+s8Azr6sd29ljp4Q0GpZSDZJtrI8IH+72IObPbtnMPehFqb63sW5SzUbnbDmN5x
         RT/YG8aCTsF7r6eWkA7jZHhC3aKogJw4zCNmusXVCcAOI9fNMQTI5IFnKi8fOHEplJZy
         0KTl/ecgkv8BvaIzB27IPs6m9uO3tqdqWcIUHQicMJ2ADBFrDiiYqKGOdHRVgiTjbL2p
         1En9A6MxDasZtBneskHKj9WII2ueSSWp9rNpSiD/ljckLDplDmXnpUpQWcpDg9l2V5dF
         I8NA==
X-Gm-Message-State: AGi0PuaKXMEqHTfOpBiaFpr2bhsD4QJb5/RI/X24DHTY80qa1ob6DLXN
        c6tmJ5tnQO8yDDQ6YhkOYIjWY5Xp
X-Google-Smtp-Source: APiQypLXHKX7AYzOo6aT1pdgGx7QYItcK2R5o+y9v7RhxbFCnNumSzVWQDfvYymxCdN7xeiemOpfcg==
X-Received: by 2002:adf:fc92:: with SMTP id g18mr10257399wrr.10.1587231694789;
        Sat, 18 Apr 2020 10:41:34 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id y10sm12393242wma.5.2020.04.18.10.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 10:41:33 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, rdunlap@infradead.org,
        gregkh@linuxfoundation.org
Subject: [PATCH] docs: ioctl-number.rst: add habanalabs driver IOCTL
Date:   Sat, 18 Apr 2020 20:41:32 +0300
Message-Id: <20200418174132.10597-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Habanalabs driver in misc exposes several IOCTLs to userspace. Document the
letter and IOCTLs number range in ioctl-number.rst.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index f759edafd938..52bf58417653 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -146,6 +146,7 @@ Code  Seq#    Include File                                           Comments
 'H'   40-4F  sound/hdspm.h                                           conflict!
 'H'   40-4F  sound/hdsp.h                                            conflict!
 'H'   90     sound/usb/usx2y/usb_stream.h
+'H'   00-0F  uapi/misc/habanalabs.h                                  conflict!
 'H'   A0     uapi/linux/usb/cdc-wdm.h
 'H'   C0-F0  net/bluetooth/hci.h                                     conflict!
 'H'   C0-DF  net/bluetooth/hidp/hidp.h                               conflict!
-- 
2.17.1

