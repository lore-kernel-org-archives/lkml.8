Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B988AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76D222C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyRuZKxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgHCU67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:58:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25934 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728605AbgHCU66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EgJGJjLXNDNxv1S9tFSxLl/zl31va0ARwAnPHhIniqo=;
        b=LyRuZKxX7eK2cmQZVOVIPasxC0CyFldaVZc9fkMcJQN+xUl8PoMmsfOQ9mICnre2gZr9Bk
        o5j+ja+bVCNbQWdi4Ot/HWJd2qMRUyUNPCiJdguiEFaXtGgAkIf07ORRtAtppE/0Oyat8p
        7k3LPuQl3rQ6qnah0xnZM9U9sz0yHKE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-8JRegVZQNbaU4iyw_V7xrg-1; Mon, 03 Aug 2020 16:58:56 -0400
X-MC-Unique: 8JRegVZQNbaU4iyw_V7xrg-1
Received: by mail-qk1-f198.google.com with SMTP id v16so27024212qka.18
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EgJGJjLXNDNxv1S9tFSxLl/zl31va0ARwAnPHhIniqo=;
        b=Brlqxt+r3DMntwJEZwIYfOe31pWnxWC4oO/G5875LOhlt+DRO7U4LEDH0TKgZl139c
         3WoEMmctDFL+k8NVh/kPbdaGr5lcf4dMT/dXAyHsQe+E3H4evwavL1RbW44odZeq93LJ
         7v5c6ZTtq4iND8q9tQx9nGs2zRlx46XlHNs9jzEFBzcjox/HLygf2pG9/S6zntVXTCDF
         sHUacatv151153ultwRYMm20vTySvdVaC59kEIZ1RWCaP/t8DSBwrH00Ovx9/iBNNfdp
         9C1CnRE6C008SQq/ms2tCPdxkCUaSGcJXSAme824WDpYWmBXaEVTuzTfxG2vDeOZwB1H
         H+AA==
X-Gm-Message-State: AOAM532Vb27Z8zwzE7IijIg0hdtyUbh0g1pUMOts2K4DxKLKcJRC53fT
        ZwkKHQFO65HOdw5EM/zYH3eJzfTQcTm9CBGIZVY5XgQsW9jv9toI6KkXFmlp+WZbvgpOowPrtbR
        PapFHu/TTEMsZnZWib3oxgpRS
X-Received: by 2002:ae9:e00b:: with SMTP id m11mr16520748qkk.341.1596488335098;
        Mon, 03 Aug 2020 13:58:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhufE6JFaK7bGmm6mLbB9GDhDAi6TBHVwCMJewMzhq9hJKY2E/SiLeAoUb/AkDMVbg0hKQkg==
X-Received: by 2002:ae9:e00b:: with SMTP id m11mr16520707qkk.341.1596488334744;
        Mon, 03 Aug 2020 13:58:54 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id n33sm22173580qtd.43.2020.08.03.13.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:58:54 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:58:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net
Subject: [PATCH v2 04/24] virtio_9p: correct tags for config space fields
Message-ID: <20200803205814.540410-5-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag config space fields as having virtio endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_9p.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_9p.h b/include/uapi/linux/virtio_9p.h
index 277c4ad44e84..441047432258 100644
--- a/include/uapi/linux/virtio_9p.h
+++ b/include/uapi/linux/virtio_9p.h
@@ -25,7 +25,7 @@
  * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
  * SUCH DAMAGE. */
-#include <linux/types.h>
+#include <linux/virtio_types.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
 
@@ -36,7 +36,7 @@
 
 struct virtio_9p_config {
 	/* length of the tag name */
-	__u16 tag_len;
+	__virtio16 tag_len;
 	/* non-NULL terminated tag name */
 	__u8 tag[0];
 } __attribute__((packed));
-- 
MST

