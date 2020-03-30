Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FA3C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833C420780
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlBhFaJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgC3Qt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:49:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44385 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgC3Qt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:49:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id 142so8913805pgf.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gx8Kl8+EY+rcRBFr5LGlmy7WmWDFnO/S1WsycTlgciI=;
        b=AlBhFaJpybQjT+Y/R1/ukeYB8p7OXgFWmlij6thTPNfDrjqf12rMx3IRH7bg5p6ql6
         DPl8LDEIaW4+x6aiLqi2bR+6/RkniLZ3ajBUCzE65LOdEAtaN4IabsmyA7uJlQSb1cKq
         eNoUcEN7AWtUXbkSKw5UnubTYhIJWS5NTXeLhQV6MU5LbEbB8B0BV/6T6yGSkrkdcUWY
         m/3YW5cMULoqZLL0Ujkx+RnuZMAoZuSqlN9SXa/mo0PSrL4XrB+Oz9WF265Ei1ky8n6m
         wkCy7YZbAWqtbEOXA7RMq9RAuJWnEmggxo/hrORxKeC7u36jH1s4h9cij+ufDWSmSF/A
         yWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gx8Kl8+EY+rcRBFr5LGlmy7WmWDFnO/S1WsycTlgciI=;
        b=uDhXhIhj+HsZA4s+0h6fEkK2ypT/zE1t7MympNM3Mq/3jU6lpQYMqHlx/LGt0b3lyh
         owpaBTaavRV8xaj+kQ0NCorY8u4oDhkr31h3hR1I6KKVL9+5OKyhZwub/769q5G11aSy
         wE8FObX4vjGsP3GZpm7jEVraAxWDnve0VFZfy/tu+SgCNW8EfHn1uz7MfB7ftNCzqn/E
         QBMs7xgXHtbLTU+31DXeFpwlK32lzIFw79S1BuTOqLUoW9lklCFGMWbkpL4ggYreiBj4
         CDyKu/QAG/p3SdigDq9uZ8JugUEZVbW8uBQENcvjhQTtoW2qgfY5nn+P2aWFulR6n9k1
         Segw==
X-Gm-Message-State: ANhLgQ1/o+ZdcOn6c/vvGlmMquvr0sJzDkOyimQA1SG4NHdxkTy0aBT3
        QOKE2lQ4sOvHnTF66eRee5c=
X-Google-Smtp-Source: ADFU+vtRJMNIDAiTCtZ39ZJm5gXb64KJVU5KLLDxAZWgYFxaOWcjSZFmmb2OUvWsIYpSUmik+0JT2w==
X-Received: by 2002:a63:18b:: with SMTP id 133mr13911508pgb.422.1585586965663;
        Mon, 30 Mar 2020 09:49:25 -0700 (PDT)
Received: from ManjaroKDE ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id h4sm10587870pfg.177.2020.03.30.09.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 09:49:25 -0700 (PDT)
Message-ID: <5bc717b81ae009b5a1e47607f23afd3b3c23b102.camel@gmail.com>
Subject: Re: [PATCH v3] staging: vt6656: add error code handling to unused
 variable
From:   John Wyatt <jbwyatt4@gmail.com>
To:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Cc:     outreachy-kernel@googlegroups.com,
        Julia Lawall <julia.lawall@inria.fr>,
        Stefano Brivio <sbrivio@redhat.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Mon, 30 Mar 2020 09:49:19 -0700
In-Reply-To: <20200330154600.GA125210@jiffies>
References: <20200329084320.619503-1-jbwyatt4@gmail.com>
         <20200330154600.GA125210@jiffies>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-30 at 16:46 +0100, Quentin Deslandes wrote:
> On 03/29/20 01:43:20, John B. Wyatt IV wrote:
> > Add error code handling to unused 'ret' variable that was never
> > used.
> > Return an error code from functions called within
> > vnt_radio_power_on.
> > 
> > Issue reported by coccinelle (coccicheck).
> > 
> > Suggested-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> > Suggested-by: Stefano Brivio <sbrivio@redhat.com>
> > Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
> > ---
> > v3: Forgot to add v2 code changes to commit.
> > 
> > v2: Replace goto statements with return.
> >     Remove last if check because it was unneeded.
> >     Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> 
> Because it's after the comment line (---), this Suggested-by tag will
> be
> stripped-off when applying the patch.

Understood.

> If you could fix it, then add my review tag.
> 
> Reviewed-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> 
> Thanks,
> Quentin

Done. Please see v4.

