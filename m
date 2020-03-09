Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA25C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E858124649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQGvMJGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgCIWZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:25:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54016 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727279AbgCIWZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583792713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+zy2FHQw9KFVxtHaLqa0r2t8FDa4q1KvvQqvnAapvQ=;
        b=PQGvMJGTBaYcs0rW0oLvdJ0EGdgYekssdg1jPHo8JfqnLldI+k0sebEtrFfqFGIKp1bGTa
        2sUn7hojVr2BgKYK7Iu1bETQoY2DBFQL+3ahKXEuqHi6FPl3ou2wvLwudP/GhxZmAHQgIm
        klSsZz2AOTo4X6n/8cYR93swscaAksE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-eKDCn4dNOuGTopM_1kJuFA-1; Mon, 09 Mar 2020 18:25:12 -0400
X-MC-Unique: eKDCn4dNOuGTopM_1kJuFA-1
Received: by mail-qk1-f199.google.com with SMTP id t186so8302817qkh.22
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 15:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v+zy2FHQw9KFVxtHaLqa0r2t8FDa4q1KvvQqvnAapvQ=;
        b=nfFy3mksVqLERNa9Sx3uBt9WNkxLBjH7MgdkrzbBalpG64A/8w7WVIA0PrZ7fjsodq
         UCy6qlpAClGyHdd32yOFOe6JGQJzAukWh80737+OKP9xLijNLgyrrUwQzeKxdgpjSidS
         ErFo/KLcQ+QHgo4JU6swyrTqN2RinUryTS+iP4vovbP++0G2TVSv1izJonnz27zSURjM
         5O5/Ha6eXcQF1ZyZei3f+ml23Y/YoDwOS5pi0ATlbfkXpJ5ue330C13qZH3gZBy/fV4E
         0Gf2+wnMF3Do2PLTQM+OC5SaCGzgQcCYZFJSb5Ab/jd6IaCH9kvWI6CEVciVhoS0Iqqb
         DMbg==
X-Gm-Message-State: ANhLgQ0l52aRxBVd9xzlBD80XtYYZaeb1LLErWba1i++dAcAkEh8bYQF
        km3Uz4yFng0zvPP3MZNrJI9hznF6G+ZvEHqZ/ERsVl2CeoMkrkFMIXhi1yHQyZKOdhxH9ukkyfy
        9IKpUi+95imwruTrbY5lbS6r6
X-Received: by 2002:ac8:48cf:: with SMTP id l15mr9587161qtr.234.1583792711333;
        Mon, 09 Mar 2020 15:25:11 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvR8HfHsn5t5n2MA4zPw5mx1lMcYtkK1WmmuD1HcoGfkiSxIp9vInOidMMrxX+bzf4bJvhv4w==
X-Received: by 2002:ac8:48cf:: with SMTP id l15mr9587138qtr.234.1583792711121;
        Mon, 09 Mar 2020 15:25:11 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id d185sm23652354qkf.46.2020.03.09.15.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 15:25:10 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v6 08/14] KVM: selftests: Always clear dirty bitmap after iteration
Date:   Mon,  9 Mar 2020 18:25:08 -0400
Message-Id: <20200309222508.345499-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309214424.330363-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't clear the dirty bitmap before because KVM_GET_DIRTY_LOG will
clear it for us before copying the dirty log onto it.  However we'd
still better to clear it explicitly instead of assuming the kernel
will always do it for us.

More importantly, in the upcoming dirty ring tests we'll start to
fetch dirty pages from a ring buffer, so no one is going to clear the
dirty bitmap for us.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 5614222a6628..3c0ffd34b3b0 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -197,7 +197,7 @@ static void vm_dirty_log_verify(unsigned long *bmap)
 				    page);
 		}
 
-		if (test_bit_le(page, bmap)) {
+		if (test_and_clear_bit_le(page, bmap)) {
 			host_dirty_count++;
 			/*
 			 * If the bit is set, the value written onto
-- 
2.24.1

