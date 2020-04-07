Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA39C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9FE2051A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNQuaUwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgDGMdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:33:41 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:33578 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgDGMdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:33:41 -0400
Received: by mail-qk1-f180.google.com with SMTP id v7so1397320qkc.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q/PmmDSB9YDFW45uzXZhzz5ulk09NKj81ncn8zjqWNo=;
        b=TNQuaUwxzGJ6TfynpcbdK6vu+dZ/SanQB3s/s6O7gkSoF6ZykKKqnUMhpUDZ4mlCM6
         ZAa8kKKuhoAQyIdYKCz6cADmEBb9tHFJ5VEpn84Kx1iwWQT+DVDs0vFSyAdAzscMiwUV
         VUrfMmvtvoBP07D+IHReGVDlCjiIQpvEemnbYW3Fl1sC67BNEwZKE89+l5p6nNi/gN63
         Xobcwc2nmrPhYEewyeZbl2s+Xm6d6YeYfDWJaXSrAcNgrankxRhUdMjIiyEo5i0HJO3/
         4NiQwNDrJfOmf9sUbA/OXUHCAsM4cLliCO8Dx0BZs91SW4H7AgTqBTi/CVn3yagXV7rK
         SWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q/PmmDSB9YDFW45uzXZhzz5ulk09NKj81ncn8zjqWNo=;
        b=ltfua3Dmbzoq2XYgpsBo2/kI8Oqf1aVtbypGoTOuE0a2NtqIC86X5Mq9m1LZd3a7y4
         zCgVYc4s2pGNEsctzvzm03LEg1sXCwLYOGXpLvbGu/92Tlh5gHCOEuEdg1EbAAiuYRXW
         XoZyjJ41cv+XPlDbvqptKmseUm/OuyeOv/ePsGLXmtnRx2r6ArTnuMBER2JxkXF0VtEh
         iNCvSSJuhsFnrxYXKzgW7qjgbkBF4V1XyCC+OylGbryeHla5YGlqBC8tHwxX8h9udsHn
         9lRjZbCV0uO2WoOMwGVw5Vu9L3zfYGwyzEcT+6LsXKXyCOuUAU8EI4HrQXCulupX0X/n
         gAuA==
X-Gm-Message-State: AGi0Pubc15Q9stn9hHpiT2W1UPdjT565G1nhO+q0FIeRvnyzn9fbG6h6
        fvpOzDMC2ivFQ1YY8ySHB6g=
X-Google-Smtp-Source: APiQypK+TF9+/hdZn+2/VWkfgMmUvYcJup6++BYfNRY4aC9j4FgUvCu5EQ49eE8AxNR46cv0Cku5VA==
X-Received: by 2002:a37:7987:: with SMTP id u129mr1915603qkc.312.1586262820798;
        Tue, 07 Apr 2020 05:33:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id e10sm4044797qtj.76.2020.04.07.05.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 05:33:40 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6580D409A3; Tue,  7 Apr 2020 09:33:38 -0300 (-03)
Date:   Tue, 7 Apr 2020 09:33:38 -0300
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        He Zhe <zhe.he@windriver.com>, tstoyanov@vmware.com,
        hewenliang4@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools lib traceevent: Take care of return value of
 asprintf
Message-ID: <20200407123338.GB8452@kernel.org>
References: <1582163930-233692-1-git-send-email-zhe.he@windriver.com>
 <5f7589c3-323d-1a5c-685c-9becd87a690b@windriver.com>
 <20200325133551.GA19495@redhat.com>
 <20200406222411.386ba51d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406222411.386ba51d@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 06, 2020 at 10:24:11PM -0400, Steven Rostedt escreveu:
> On Wed, 25 Mar 2020 10:35:51 -0300
> Arnaldo Carvalho de Melo <acme@redhat.com> wrote:
> 
> > Em Wed, Mar 25, 2020 at 09:05:46PM +0800, He Zhe escreveu:
> > > Can this be considered for the moment?  
> > 
> > Rostedt, have you looked at this?
> > 
> 
> Bah, I did but forgot to reply.
> 
> Yes, add my Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Sorry for not sending this out earlier.

no problem, I'm finishing a round of tests to submit a batch to Ingo,
will pick it up for the next one.

Thanks,

- Arnaldo
