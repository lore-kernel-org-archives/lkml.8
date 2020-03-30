Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA1CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5683A2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bx72mUxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgC3Lwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:52:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45638 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgC3Lwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:52:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id t4so668263plq.12;
        Mon, 30 Mar 2020 04:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eg5ugs9X241d0CyEHmbcuFz60tm64fkmmQDdwTBJmwo=;
        b=bx72mUxy7UhUrj/cFQtM3eS3lb41tkad+HkCfGl7ALAjXH3z2dhSxVA9srYRsjMG7g
         EXx2GambzNP9ODeY640qVmq5Gu4R+JHDXZq+yyWf3+TIQe4xcdu6zMsJhn9aA3JRtUDQ
         q6KxjpPJ3QoZVvkp4UJMcyNB8IsesWuOwLdHNVJxlVKwPudGdTqgVglMfsKR0EQ6bBRt
         zID7u4h3SB9c43fysjMa2VL+L9FLQABlAXx05yJIbDxIT3cwm/ko4qIzTWXOR3w2o9/r
         UbghdxeYQU2RR/afULeC3pRkuZ4w3C+3jQVSIOunRm2DsOA1N+J4886HS4V/iNDRtlOq
         4bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eg5ugs9X241d0CyEHmbcuFz60tm64fkmmQDdwTBJmwo=;
        b=cmqvy2z4mkoy/+BWqsfmp3o4yVHbAgidUIsvzsY0l0coIAAp65Ot/APyCvkudzASIz
         sGmi23EwcHNkoJvvDGUIQ0N6pxEysvhNB6Elxeg6Ui+myWHcptANlvyF0RLPhLzYTo+g
         F35nUTdn7EcB1QA4hLguJLDSaOBQ4egGIaEJOj3G/i6+SOLyfH5eEPrI6f4yJaI0bLyb
         WWfUN0WyPWqP+ICPH1cLewfRG2gSay+HwBKoQ4gXwR2y6UmphihmP7jxmibXzmCL7wcV
         BQfUtWc2ziQ8W9twdcBdrdZYrF+I7VDpNa3/4tyfDwpch49VS6iqX6ZfEgegdO4X2s2v
         8BrA==
X-Gm-Message-State: ANhLgQ3vTOpzu4e05LK+3OlkMkQNmeVKZDsiwgcumAGfgYlK1br7qjP4
        t0/dllbX445s65Fzv2ExSg==
X-Google-Smtp-Source: ADFU+vvHPxPL9x5Yn46J0zk4QFbJpW4YEMsI5pazZEOmCFYJZehaxlAEidJsvORcHfq26MYyODPWZw==
X-Received: by 2002:a17:902:788e:: with SMTP id q14mr12138962pll.72.1585569169503;
        Mon, 30 Mar 2020 04:52:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:d3b:3d6b:7942:93fd:fd15:96f0])
        by smtp.gmail.com with ESMTPSA id i4sm10012756pfq.82.2020.03.30.04.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 04:52:48 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     gregkh@linuxfoundation.org, hariprasad.kelam@gmail.com,
        colin.king@canonical.com, tony.olech@elandigitalsystems.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrianov@ispras.ru
Subject: Possible data-race related bug in u132_hcd module.
Date:   Mon, 30 Mar 2020 17:22:43 +0530
Message-Id: <20200330115243.11107-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This bug is found by  Linux Driver Verification project (linuxtesting.org).

The bug is related to the parallel execution of u132_probe() function and u132_hcd_exit() function in u132_hcd.c. In case the module is unloaded when the probe function is executing there can be data race as the mutex lock u132_module_lock is not used properly. 

i) Usage of mutex lock only when writing into the u132_exiting variable in u132_hcd_exit(). The lock is not used when this variable is read in u132_probe().

Moreover, this variable does not serve its purpose, as even if locking is used while the u132_exiting variable is read in probe(), the function may still miss that exit function is executing if it acquires the mutex before exit() function does.

How to fix this?

ii) Usage of mutex while adding entries in u132_static_list in probe function but not in exit function while unregistering.
This should be easy to fix by holding the mutex in the exit function as well.

There can be other synchronization problems related to the usage of u132_module_lock in this module, I have only spotted these so far.

Please let me know if this bug report is helpful and I can send a patch fixing it.

Thank you,
Madhuparna
