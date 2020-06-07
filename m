Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2409C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 14:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2AF2067B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 14:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSvRuJRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgFGOMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 10:12:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25374 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726823AbgFGOLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 10:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591539107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yeTF/4xoJH8JkJEZ+aqTMVrfSsZomUNfl5tfcaaPRM=;
        b=aSvRuJRDwZN0P760tlt/8JqHTuIupkQJfd6ntM4ACM0Zt4/lhCkAhGygx6pjOeyCCqBE7F
        vXASTvptrpnqzElUZ/GsZoBNEHmSGAMR0hwe7JugtCm1I+SlD4Gk4Q33BJtXuVhtK7WKDx
        jiUF0lwO3k6zbrdLprkKADXHSnmnKPc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-mLKP1d58Pcy9Npl0fbDbEA-1; Sun, 07 Jun 2020 10:11:45 -0400
X-MC-Unique: mLKP1d58Pcy9Npl0fbDbEA-1
Received: by mail-wm1-f70.google.com with SMTP id t145so4298276wmt.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 07:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8yeTF/4xoJH8JkJEZ+aqTMVrfSsZomUNfl5tfcaaPRM=;
        b=dpFmqWUMTwqSzVnKUERzhc6Qqq2N09U9iR3QQg4kQxnpZhBU/rzOVChmLEnxICwyCd
         qxm4+LfhXYxaRws3nmGnDQAZC+Uoc0LyhB5sIZrIcNOJBJ6QDI5iFoIRZJT26ApkCwP8
         AwxsvPk6V4/cC+4ykZriQheqzpHnMlPD5gN6ItEZtN3T8DZWm58u7xdqudN84rMTd2ri
         8I/5A2FeVwnwqTkSstRTM//QsAfthXWfoM0O6Q5sOnTQ+MAz30xHQtDFg5IG1sM5jwLY
         pFh9Tmj2oCJsl1FaYFeS55wlcJd5eBWLWFBETPoUmrMOYYENRYXpuBUyHJidxIXIDglP
         TPzA==
X-Gm-Message-State: AOAM530MjAhpVXyxFkrTxloK4r8itdcvVcTCo79fnZS0Ac9JAQ8J9/fi
        xU6xkH/re0J7fyo/kjGI9bpZCV7lOpdA1QSZNsaZMJdhpAGqJASrKIB3ypJKC/JZ2sv50+hUEhq
        Tv8V56939JDPaI96d93RpbSnc
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr12417404wmi.165.1591539104515;
        Sun, 07 Jun 2020 07:11:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw57J09cTKbeRmJVX90+N+R46OyNEvndsO7VwU1Ip6tS22b7zKgKAjdQddCV5K1/YT0vuS/Pg==
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr12417393wmi.165.1591539104370;
        Sun, 07 Jun 2020 07:11:44 -0700 (PDT)
Received: from redhat.com (bzq-82-81-31-23.red.bezeqint.net. [82.81.31.23])
        by smtp.gmail.com with ESMTPSA id h5sm20290400wrw.85.2020.06.07.07.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 07:11:44 -0700 (PDT)
Date:   Sun, 7 Jun 2020 10:11:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        eperezma@redhat.com
Subject: [PATCH RFC v5 09/13] vhost/net: avoid iov length math
Message-ID: <20200607141057.704085-10-mst@redhat.com>
References: <20200607141057.704085-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607141057.704085-1-mst@redhat.com>
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

