Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF67C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F207920789
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="EZvggVIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgCXOZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:25:01 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:40457 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgCXOY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:57 -0400
Received: by mail-pg1-f181.google.com with SMTP id t24so9081577pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=M+b5EPoZFy9O+3BjnkpArQ2labuMLhCHX8xcr7BhQw4=;
        b=EZvggVIeGhevoh5NNxYlACMHgWkmY/K0mXslP/icPJXJARfdHiBzYBbP2AAXKsTKWf
         Y+0DkJJBOrWgL+qFV/AZXq6+jssUvCKdQLzQ5rnEmnSKQkEMm66E+WY2BdwdpdlypYW7
         3TXISRmLCUK8iy9hTpd51B8hIocqvSzGxUsmhAu8z0YPV65dX4jK4g1TTngz41IOSxDJ
         D0L+MFnG0876R9ojtX3MKplkVwKiex+gs9GdmUgzfzyIbFEofrR8E+XmyORULQms7ce9
         FCyT615Ds3QxgoVubGxDxNt4cU2+05u4A2aZF0H63HsNm+NMq1jpwurBWvzagR/3iOhz
         7pKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=M+b5EPoZFy9O+3BjnkpArQ2labuMLhCHX8xcr7BhQw4=;
        b=ODT/Ihw0FQfi7UR5FI2EBrRHXSvr2AYKvl6dn3xLf6oG8+CrATqnefCHgo09dwG0P/
         pZMwLtLVORgdIX2/xM/tGvLETjCVywmcFnAwOvgSXv3lxX6NC1HFK0zWlo5Rl3S8GuPI
         6jhwOrMBEZcektpAfenzJNzzAQnznhfknJIMxR95Hdz5cCTprHoUOmu+7YfllvvHXPbA
         CeA623FFhit6T2Y+8CqAH9L7XTcnKhe4w/QiT/7ZTDThIRbfQENRahGOunEpdYUV2MnD
         +/W6Qs5Tf/Z9LUuuSxcoLVSuxZXBDt+wBoT311W1kjKHjH0TjQHbkSdoyYRKmjHuJkPf
         nkVQ==
X-Gm-Message-State: ANhLgQ1e4BgXyKQ6OIl3m9o+TttFtc/frDqSEF12DZh8+WFUVcyjtETn
        4Ue4Abc8OhQDGj96TVTo6oKFYi/6bj7sFA==
X-Google-Smtp-Source: ADFU+vs4Vjoxi8fKdz2fa2151B1/wWCQtLfuaxVIsCssdZtu8du9Kphyj1xLW+Es30aScCdl4gd6IQ==
X-Received: by 2002:aa7:8f03:: with SMTP id x3mr30431553pfr.40.1585059895835;
        Tue, 24 Mar 2020 07:24:55 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id s76sm6680650pgc.64.2020.03.24.07.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 07:24:55 -0700 (PDT)
To:     stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Mark Salyzyn <salyzyn@android.com>
Subject: locks use-after-free stable request
Message-ID: <52be02d3-3a6a-c8b8-4177-5cc1d67aedd4@android.com>
Date:   Tue, 24 Mar 2020 07:24:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Referencing upstream fixes commit 
dcf23ac3e846ca0cf626c155a0e3fcbbcf4fae8a ("locks: reinstate 
locks_delete_block optimization") and commit 
6d390e4b5d48ec03bb87e63cf0a2bff5f4e116da ("locks: fix a potential 
use-after-free problem when wakeup a waiter") and possibly address 
CVE-2019-19769.

Please apply to all relevant stable trees including 5.4, 4.19 and below. 
Confirmed they apply cleanly to 5.4 and 4.19.


Signed-off-by: Mark Salyzyn <salyzyn@android.com>

Cc: stable@vger.kernel.org

Cc: linux-kernel@vger.kernel.org

Cc: kernel-team@android.com

