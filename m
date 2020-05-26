Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C671C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68540208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590532284;
	bh=OwNgAEE3RelOWrT98pheb0NSDXIvjfOun/TDUH9Q9hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mz1STJX1kXqZEWrXDLy8V71k1OiLf6VFSGgVN4IgqGTBkG7Wi+meUJZXNupS3w3qZ
	 NApMEkXiAVzTnfB2vWefhX0Ldov1EvYNCu9xfXgaPpzbJ6vq4AZkfwUjUJfYNPus4r
	 Ls3jR48S0U1F5+EoeMTgl36uo1uelUxcJe/usKdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392085AbgEZWbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:31:24 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33694 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbgEZWbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:31:23 -0400
Received: by mail-io1-f68.google.com with SMTP id k18so23936380ion.0;
        Tue, 26 May 2020 15:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7PO7nGDx6i6iJvomFwFAJKzAEqtQa3QMoljS+fScBDg=;
        b=nbZDkSm5AqNOaKEix7x2K5Yy8YqwEiaiLZQYPhDhKNTUrQU+/V7cYR/4R1mpP3PyFW
         4ELwurhwz6evC9p6vehiJLv0KvASi9GZkW1uL7s+lOJtwA2X540X7kTf11bhyigKo614
         iDBCT0iwLr4s8nmDkLJ8y1dvjG1jHXQNC1PXQ8GoCbOI6uJV3DDfpzo99TTy5lRY8j3b
         OI+GukfskFOclIQ05OaQ0cP8Oax664fkYTlmr3hhb0z0ydR5vBCblIP0HnhloQaypsR8
         8N0Mq054FIGhA2bkKQ9dWEyK9KcRTe78+4nmhClBKOHfanlZfqUwllzZ0EhC/+UM+zSO
         9BeQ==
X-Gm-Message-State: AOAM531AbOT8TCFilwZFo4sFwC0IkN7D1nNI7GCbA8v51TJVRNCesWKD
        Rrqtlmd8xgngSAOgY7N91A==
X-Google-Smtp-Source: ABdhPJzg3/7lwTB77ZTQN1hMWzcgg9hexWm7c31lZM6rBv5yZyP5Irit38gNDKsTOeMlYqaaRRoNkw==
X-Received: by 2002:a6b:f812:: with SMTP id o18mr18386246ioh.87.1590532282441;
        Tue, 26 May 2020 15:31:22 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f15sm661633ill.58.2020.05.26.15.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:31:21 -0700 (PDT)
Received: (nullmailer pid 504022 invoked by uid 1000);
        Tue, 26 May 2020 22:31:20 -0000
Date:   Tue, 26 May 2020 16:31:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mturquette@baylibre.com, festevam@gmail.com,
        shawnguo@kernel.org, sboyd@kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linux-imx@nxp.com, s.hauer@pengutronix.de
Subject: Re: [PATCH V5 4/5] dt-bindings: clock: Convert i.MX6SLL clock to
 json-schema
Message-ID: <20200526223120.GA503921@bogus>
References: <1589328684-1397-1-git-send-email-Anson.Huang@nxp.com>
 <1589328684-1397-5-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589328684-1397-5-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 08:11:23 +0800, Anson Huang wrote:
> Convert the i.MX6SLL clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
> Changes since V4:
> 	- add descriptions for interrupts and each item of it.
> ---
>  .../devicetree/bindings/clock/imx6sll-clock.txt    | 36 ------------
>  .../devicetree/bindings/clock/imx6sll-clock.yaml   | 66 ++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx6sll-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx6sll-clock.yaml
> 

Applied, thanks!
