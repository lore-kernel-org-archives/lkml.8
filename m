Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5827FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25EA62074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3TlP8oO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgFPGuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgFPGt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:49:59 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6631FC05BD43;
        Mon, 15 Jun 2020 23:49:59 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n2so7938124pld.13;
        Mon, 15 Jun 2020 23:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k6KdWN1aWqxsRpli5fdDQkS+WbX+LNs+UJ489ru0UBA=;
        b=B3TlP8oOplArpXS8xzAMHHSfevNnQVQvxI9CHKduig7MxHKOvNgQD8mXljhP5LP/NP
         JF2bjzVwU7VvbkQmzvI0DbaJlWeYRlAXbvVxzmNbAYlL/F00D7VMABBlWoiNnGkxxDXC
         8AEijVCGQOPg+EyOIxCWEJ+8Wkv6kj1eU35yw//ujiLYSbZf7VtFYu4J+dyh+v7AdBW4
         nxJ7YTJs9W0qLyI3ejaIbR1xFQ8HtX2wMsN1RzBRyiqHxxQmQFTW+RRBHG1RasJefbZ8
         ta/6++IF6ilbIuGRenEYJ6K+KvnWMOklBXnYzR+gm9XaoD1bJ8Nw0ikCHv/5JjV6Zg42
         cESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k6KdWN1aWqxsRpli5fdDQkS+WbX+LNs+UJ489ru0UBA=;
        b=GM4Q0qYrjDRB5+u3bbY2oCxg0m7aTffzm6UM2WtbQr5MxC11Jsidu6Sq7d/61VdVGX
         JqmBsg3QExTlv+ng6qrq6jpU+NvJvKg19tlNwykUARS4aFvoosR/Qu9ayaA0tTJLJVtV
         Gwuw3aLwlqq2vGyiskVTRTU7fLZcKR+6TRqC3p7mbY+ypSWpBwIqVWcpX4cPKcUyfq/Q
         gzmy2BitXimSz+8PMh3r042kVVQwCvKaq9UTX0FJ8ix5DV3FcWCuPLJW7Lb7c5njRcqh
         5r+qDiniWP/rs5bXB1ucAopDbP+nWWbf6ux6FW7UVrTR/gWYUcjnCH+mr3x3sVY72v+L
         gnLw==
X-Gm-Message-State: AOAM530EQvTul95aKqP6VftVj7jgksnMz1im0OBcOvxxdcSkpPak8Nrn
        lSVj5V8OLZg0XWsBvc2GiNQ=
X-Google-Smtp-Source: ABdhPJwwpLsocmGibnn2+XMOZOy441mhMdeTmNlcabHbwMyk6o3zw1vfZlt7tKcxEMc+YT0a+H2fgg==
X-Received: by 2002:a17:902:7043:: with SMTP id h3mr898978plt.200.1592290198934;
        Mon, 15 Jun 2020 23:49:58 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id n65sm15409324pfn.17.2020.06.15.23.49.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 23:49:58 -0700 (PDT)
From:   Geliang Tang <geliangtang@gmail.com>
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Geliang Tang <geliangtang@gmail.com>, netdev@vger.kernel.org,
        mptcp@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] add MP_PRIO, MP_FAIL and MP_FASTCLOSE suboptions handling
Date:   Tue, 16 Jun 2020 14:47:35 +0800
Message-Id: <cover.1592289629.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add handling for sending and receiving the MP_PRIO, MP_FAIL, and
MP_FASTCLOSE suboptions.

Geliang Tang (3):
  mptcp: add MP_PRIO suboption handling
  mptcp: add MP_FAIL suboption handling
  mptcp: add MP_FASTCLOSE suboption handling

 net/mptcp/options.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  9 +++++++++
 2 files changed, 57 insertions(+)

-- 
2.17.1

