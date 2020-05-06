Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C311AC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9761C206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2nTfqPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgEFGbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725882AbgEFGbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:31:42 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761D1C061A0F;
        Tue,  5 May 2020 23:31:42 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t40so374928pjb.3;
        Tue, 05 May 2020 23:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7EFV875GnuITuP+XzUmtUAo5f3YwSiu3ifjVfUUNcrU=;
        b=n2nTfqPYxIVoXKD3mc06paVUcywQOX0ADMpLQVYE+GGEw5xsQxsQjPH1ctWwfCiRZY
         kAklE2EjIopxFBCSaissFj2+vlJCL7lD0MwGYSQtshKxmB65eaCZhlCbD/FAsB1eyasZ
         jS/ydK8TIUifxZzKjF/d1aZTzADHRTgXL7Zip69HA011K/yVmEvhU86TAOOvR7dT2SzH
         Txdv9qsVayFigM9XlaycxYzBbdNlqrlTRC51qFd6y6JXsAyrRXyc6FCeGzhytxd8a7Ax
         Wm9JGgLg+g+RfGpXcQG6Wf3jLap2L7yqy5iB3VUWCrH3LtZEQWs/JrEJeNbvKdQZjj+s
         ZvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7EFV875GnuITuP+XzUmtUAo5f3YwSiu3ifjVfUUNcrU=;
        b=pJxUgNVqrIp54UmEuLo3WF9R4w7ERDsTqmbEiQLIqeqxvZsSsNb8AcGSrue4+HUmo/
         BNe9a40zBpIfwIv+2IjatcWBPuKw/PFsufl4OtHO+ibIdLEfrg+ZoG7KBotMqUMjLyyF
         uR2S+DIWFTx9dz2J9CjeZrxH44qat/IvhDj/YgOSY/xeI3739WtTvxqK6QTyaeI/qfid
         1ZUR+nC3iw0uo38oZwtaWN+dMbkYvdRMq2pnpgXUMpf9YqDam2gbiWRs/kF1SDO1evVT
         AZrMlT8PLsh5HXIWXUEvhPHSCBzpLIgPJGpYIamuarwXIFtcfvMJlL9g7WyiQ1MV51CJ
         EeAA==
X-Gm-Message-State: AGi0PubZL7AdWfaGtYzQ5Vp00/Uf7uHuL4nnyKB+q2ZhwVvT8LZOvrF+
        9bfirPLeYtXKrvVN8CI9LVw=
X-Google-Smtp-Source: APiQypIs4vmTcejtmiLefN/58enAnNgmJepQ+lo0qddyiq9LmzDZOjHbgxlJtFfDmaHTLItnhVxXBg==
X-Received: by 2002:a17:902:fe14:: with SMTP id g20mr6596435plj.330.1588746701893;
        Tue, 05 May 2020 23:31:41 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id y3sm3771975pjb.41.2020.05.05.23.31.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 23:31:41 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: display: Add ilitek-9341 binding
Date:   Wed,  6 May 2020 14:31:32 +0800
Message-Id: <1588746693-31078-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add document for ilitek 9341 binding to stm32f429-disco board
some hardware resource can be found here,
https://www.st.com/zh/evaluation-tools/32f429idiscovery.html
