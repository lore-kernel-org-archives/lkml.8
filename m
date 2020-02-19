Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B62C18E00
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70298206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582139875;
	bh=6UuqjgekclRB+DBK9LDoKEQ8gcEOWzuEElHK5xu8Tsk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wdEHCijsHIxsc8bdoHPo8ikyZZg3kKdH/UQtNqmGHj1Wp66DTs9YZv+2QAlVKJ4K7
	 nikiBsreleMmpO+LboGHs12C1MDguN5p9OZ7taYTyOwbJ9KVMGPOxK+y2aXuldmqME
	 dY3F2XUE5UwxihavLuYyJFI1JSZDNIfGaOO9YoHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgBSTRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:17:54 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:44308 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSTRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:17:53 -0500
Received: by mail-pg1-f172.google.com with SMTP id g3so565139pgs.11;
        Wed, 19 Feb 2020 11:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0e7gW1j8KXvVOVDldEQPd4RaLO4BTtTZ4Kvwp3jzLjs=;
        b=RgOvantUBkz5I6TSdT+6ee2HskB1W0FnF1z3t1VjcbYrd3NHSIl6pqLXKpUgINW3jk
         7sxtIwSUB+cMRsPOM//MGlRxb03NVqBlUUCHjZ4V0PagSUzkFrq3umcSyW/nkz4zb6N6
         vs4Jp0xI/paYFou7DdTw8C2By8OlnTRZyOvuZmCo3FzC56C5GeRC3DqgMLKaEZqU11P+
         S3jAiDCZ9AAqVlDVI9s8guYR9A/m940S9DIAmYqDOUFlbCIYa+S5GXg3+xfvFm5N/C1W
         MnmUsL1hZbid1muTBESfmHMMpJaUfyMbqJuuS/q1ru17dcdaPS3TFYKYSx8srx69jWAZ
         ZLHw==
X-Gm-Message-State: APjAAAV0Jrdw7XjjUeECPw/vFRv/zFfYh5+rFisf2prarXQJbNqfrXir
        KizdFSuN/IkZkxad+rq3te2pGpRim+ZxDQ==
X-Google-Smtp-Source: APXvYqxf+ynkWtprlLk4wPrYWbpp8/7MtMY/dtPho8ZLJAq/SwGiAzMD61E09c01O3iDXqFsCvSwNw==
X-Received: by 2002:a63:ad0c:: with SMTP id g12mr28864593pgf.228.1582139872666;
        Wed, 19 Feb 2020 11:17:52 -0800 (PST)
Received: from localhost ([2601:646:8a00:9810:5af3:56d9:f882:39d4])
        by smtp.gmail.com with ESMTPSA id g24sm386805pfk.92.2020.02.19.11.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 11:17:52 -0800 (PST)
From:   Paul Burton <paulburton@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paul Burton <paulburton@kernel.org>
Subject: [PATCH 0/2] MAINTAINERS: Update MIPS entry
Date:   Wed, 19 Feb 2020 11:17:28 -0800
Message-Id: <20200219191730.1277800-1-paulburton@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the MIPS entry in MAINTAINERS to reflect reality as it currently stands.

Paul Burton (2):
  MAINTAINERS: Remove Ralf Baechle as MIPS maintainer
  MAINTAINERS: Set MIPS status to Odd Fixes

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.25.1

