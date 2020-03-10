Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ECFC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FD721927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J4Gi7f6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCJReM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:34:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43439 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJReL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:34:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id q18so13510625qki.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ReiAKbolKC6wqDJ4Eh2p+jV/ZjA8CUv1/dCumntupgg=;
        b=J4Gi7f6L7GtiFhPParI0ZKdg+zxtnSfo0ZVUpL7GurmqaQ5lOdnDfBNpyLw1J0Vr0v
         F1/TMmQu7h2HYM6AxD5ZWXAjtF3qdAXE6kHAg/UFT/MJfFTCyf5OQmfm5NfdNdlQZGQw
         lxKu8qwRo0FaDOzGyXKyTk17462hFCBevw0bI2ZkxFrOyxl+eLKXJdXtI4OyBMKPiD0t
         91GCwA/Dkw7JS56IdBVTR4iHC7aJ7LkYM/G748p3+6oeblouAM25NpYXf+ik4TOI006n
         lSl1lT5NUPEos5NXKTrkhWzyMO3menjTRd+kilIZkVjIYlCvRoB9OHaOBK4JOsRES6sb
         ntpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ReiAKbolKC6wqDJ4Eh2p+jV/ZjA8CUv1/dCumntupgg=;
        b=Ylzuen5Ay4jZVz4at2x8hnk7D2dIdnpIcMFwFen5KyyHblMAS3W9enq52KifgIf+b3
         feJNfaQRxrV7VMUIXuSW966VT5tnrd/7/pBxCXNi6/f5I487MQ5QPei/DNtQW9QcvPnz
         vZZw4jt9N0ra2/XjoxPVCyaAf1mFsBPAAMpe/IGBROQb568GkQsM3Lt2BraZRR6N0Mjj
         82Y5/cpBZ2EDcWzwXmdPn2HAYdkbCIWsXwbVMdcgEZlJUeqcgQBPsO9n9PfTSs+yvxVz
         9LSEyaQ59ZuEeU+oORGQe+FZYx87woZ5GZH0pHB9dlmP20gqvicvRyy8V5B2mKqe1QiQ
         ThPg==
X-Gm-Message-State: ANhLgQ2uWTgExD/EmP9lFkp5OMwP2gVAwgBXCWgaKaDiYF7RWCHbjOwg
        PqtDwq3dmqc2/CKzUCFHMJJDD+tNVO4=
X-Google-Smtp-Source: ADFU+vvoSEf6kRCEW6fsQp0DBrXJfLVO+vsBL8MTKO/L0CUfIEYQvV9qZnrFcSzEnNNrET9XnzTFXQ==
X-Received: by 2002:a37:7d2:: with SMTP id 201mr21424287qkh.146.1583861650476;
        Tue, 10 Mar 2020 10:34:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 10sm3686785qtt.65.2020.03.10.10.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 10:34:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBild-0005j3-GL; Tue, 10 Mar 2020 14:34:09 -0300
Date:   Tue, 10 Mar 2020 14:34:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/bnxt_re: Remove a redundant 'memset'
Message-ID: <20200310173409.GA21962@ziepe.ca>
References: <20200308065442.5415-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308065442.5415-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 07:54:42AM +0100, Christophe JAILLET wrote:
> 'wqe' is already zeroed at the top of the 'while' loop, just a few lines
> below, and is not used outside of the loop.
> So there is no need to zero it here as well.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, I reworked it a bit:

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 47b0b50b71e70b..95f6d493d1b98d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2470,15 +2470,12 @@ static int bnxt_re_post_send_shadow_qp(struct bnxt_re_dev *rdev,
 				       struct bnxt_re_qp *qp,
 				       const struct ib_send_wr *wr)
 {
-	struct bnxt_qplib_swqe wqe;
 	int rc = 0, payload_sz = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&qp->sq_lock, flags);
-	memset(&wqe, 0, sizeof(wqe));
 	while (wr) {
-		/* House keeping */
-		memset(&wqe, 0, sizeof(wqe));
+		struct bnxt_qplib_swqe wqe = {};
 
 		/* Common */
 		wqe.num_sge = wr->num_sge;
