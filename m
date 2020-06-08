Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7774AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5569320810
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtDNveGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgFHMyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:54:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50954 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729578AbgFHMxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591620791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yeTF/4xoJH8JkJEZ+aqTMVrfSsZomUNfl5tfcaaPRM=;
        b=XtDNveGuZPiBncvOQ1RUrUT3Bc9YXnjnBDkm/7WhzEVOnTUpV8cw+L64ZFvRs23YgYvvXQ
        40j99TiyGu9fgMl7OesPSP8StQcwGGYNG5v3vUXHvc/TQhc5W9Qzi7A5YUpZeMX12obfaD
        3NtUcRgkCHZfEyStvevob4LnIgvDX1g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-cVUA-aqON5O_3dodwi-f5A-1; Mon, 08 Jun 2020 08:53:10 -0400
X-MC-Unique: cVUA-aqON5O_3dodwi-f5A-1
Received: by mail-wr1-f72.google.com with SMTP id j16so7067282wre.22
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8yeTF/4xoJH8JkJEZ+aqTMVrfSsZomUNfl5tfcaaPRM=;
        b=I4UUflZqe8i+3syJjt7mcnsjaEeW15d9A09gaWhMSRgFnFEyajKXRNiMwf+Jju1wAu
         LbIwIF072YRngyL92IpYu1EHfD3Jp9Bxvp4cLMFNkLKXuKGdRoSh5BlPCv1s74x8t+vJ
         KXMfjeclTn+3uFpmWGNOT0SGeQKyIwKrFkP8asrG+2oGGTU3aWE0XyLJHxh9i1aMOcl7
         M03BUUx5DHR//6wIYBIChIM6DhpbQTO0PtGjoJfiBegrq/Z9vZo3IMFQ7WWuIrnyvogx
         KEjoAT94Ci/uobgjcpGyAtvPe3lSkP4pEPZwI6sk4NaOqBasoEghFTfERNmcFCX+FVKL
         +rIA==
X-Gm-Message-State: AOAM531gOq2hV/3F0JDvSnP7vORgwxiVX9Nu9k0CtYdbFe0w89B2xNrt
        xRnQNY4E44TN9O+2UI5IAVVjiEpklk34/6gIpttBxZE6pMx5EtUJ99QHT2dNCDnXcB59yyyXyKA
        e3JVXQ4T+6eCiQGPnL7QHaDvS
X-Received: by 2002:a5d:5585:: with SMTP id i5mr23127122wrv.112.1591620788704;
        Mon, 08 Jun 2020 05:53:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy11gQF/NmEmSn0DK4pnAXz2ogVtvYom9rwdJUwvE7o5lVdYxjyVZYvm9PoiqoHGw3Jn2dmGA==
X-Received: by 2002:a5d:5585:: with SMTP id i5mr23127106wrv.112.1591620788527;
        Mon, 08 Jun 2020 05:53:08 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id z16sm23295568wrm.70.2020.06.08.05.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 05:53:08 -0700 (PDT)
Date:   Mon, 8 Jun 2020 08:53:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v6 07/11] vhost/net: avoid iov length math
Message-ID: <20200608125238.728563-8-mst@redhat.com>
References: <20200608125238.728563-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608125238.728563-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that API exposes buffer length, we no longer need to
scan IOVs to figure it out.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 830fe84912a5..0b509be8d7b1 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -607,11 +607,9 @@ static bool vhost_exceeds_maxpend(struct vhost_net *net)
 }
 
 static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
-			    size_t hdr_size, int out)
+			    size_t len, size_t hdr_size, int out)
 {
 	/* Skip header. TODO: support TSO. */
-	size_t len = iov_length(vq->iov, out);
-
 	iov_iter_init(iter, WRITE, vq->iov, out, len);
 	iov_iter_advance(iter, hdr_size);
 
@@ -640,7 +638,7 @@ static int get_tx_bufs(struct vhost_net *net,
 	}
 
 	/* Sanity check */
-	*len = init_iov_iter(vq, &msg->msg_iter, nvq->vhost_hlen, *out);
+	*len = init_iov_iter(vq, &msg->msg_iter, buf->out_len, nvq->vhost_hlen, *out);
 	if (*len == 0) {
 		vq_err(vq, "Unexpected header len for TX: %zd expected %zd\n",
 			*len, nvq->vhost_hlen);
@@ -1080,7 +1078,7 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 			nlogs += *log_num;
 			log += *log_num;
 		}
-		len = iov_length(vq->iov + seg, in);
+		len = bufs[bufcount].in_len;
 		datalen -= len;
 		++bufcount;
 		seg += in;
-- 
MST

