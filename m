Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBD0C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A5220CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKY15jJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgDFMMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:12:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31330 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727614AbgDFMMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586175164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=SPcP2t8lgIVNaWgLkTC+5LiUSA3IkB94hHSuyx8Ua+A=;
        b=gKY15jJ8dlkZlMvDqqTUeie+Ue7iiOgD3Z3rqz9UHlYHa6AqJ5aAiQz8bek/vzKDw3Zi7A
        1Hk3lSNtx4vsI1XX7/0gWzgGaPxSO4bknlBMefUBmpcWfLrVh4ffLGZ9fzSurSEYu1kV2R
        8oCpKEyL4JorUaI+q7yClp0nhu1v8+M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-vHDfwDdiOwim-G5Eu2lGBA-1; Mon, 06 Apr 2020 08:12:43 -0400
X-MC-Unique: vHDfwDdiOwim-G5Eu2lGBA-1
Received: by mail-wr1-f71.google.com with SMTP id 91so7409590wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 05:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SPcP2t8lgIVNaWgLkTC+5LiUSA3IkB94hHSuyx8Ua+A=;
        b=g1IqLff7NXPjOfg5i6s+sJ9NUDpayVdosG/i1OBaE1auDxXDAlqU96+hChY4YxuMH6
         CzeDk3B9I7+j5+CWYyRXBSVxNDJuMf61HoW35spLTYD86urjahhJfWcodt1zi086zh4R
         i3nNMbA96TQoGxxV1K+MZQT8n0PnROpiot/nplXWZ9PM15ZRkH1j0GDrgFMvuJr5xyHP
         jXZEnYBn3LdINZaqLnQCpd7CVwBK1EWMnAt9xKwqxADC7N2hRDneDxrVgSVmcTEfsLzt
         D2U3jfvDQSXFzWhvYktJFogb3Tg22742mpuDlWu36T9K8xqrAZpt9rmLqWGqejwYQyFO
         jThQ==
X-Gm-Message-State: AGi0PubhQ5R2BoRb3vKf+H2H+4awtxrT8GtTj10PjQQdejrbnMQt2jaQ
        cPDbTiVS+LeTRYnYQh4zuHvdWNAkqX7+b3IYcFrAC8xI2FvcGGT3fKG3F5He1P1uo7efAGW85/J
        LK+EgLHw6eNuvIzNTwHZDYi4t
X-Received: by 2002:adf:a448:: with SMTP id e8mr22701984wra.238.1586175162022;
        Mon, 06 Apr 2020 05:12:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypJtoKJNCJ63tLTQ6tdgF03knUbStVYMzzh9MJmBNZHx9ZArp5aMDNwqhctJfhSn0f4QzwKBZw==
X-Received: by 2002:adf:a448:: with SMTP id e8mr22701965wra.238.1586175161880;
        Mon, 06 Apr 2020 05:12:41 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id h5sm25309277wro.83.2020.04.06.05.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 05:12:41 -0700 (PDT)
Date:   Mon, 6 Apr 2020 08:12:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
        "christophe.lyon@st.com" <christophe.lyon@st.com>,
        kbuild test robot <lkp@intel.com>,
        "daniel.santos@pobox.com" <daniel.santos@pobox.com>,
        Jason Wang <jasowang@redhat.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/2] vhost: add kconfig dependencies
Message-ID: <20200406121233.109889-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kconfig dependencies to disable vhost on configs where build
currently fails.  It might be worth it to go back and fix the build
there down the road.

Changes from v1:
	add patch to disable build with ARM OABI

Michael S. Tsirkin (2):
  vdpa-sim: depend on HAS_DMA
  vhost: disable for OABI

 drivers/misc/mic/Kconfig |  2 +-
 drivers/net/caif/Kconfig |  2 +-
 drivers/vdpa/Kconfig     |  2 +-
 drivers/vhost/Kconfig    | 17 +++++++++++++----
 4 files changed, 16 insertions(+), 7 deletions(-)

-- 
MST

