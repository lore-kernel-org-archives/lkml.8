Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043AEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22FB205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rdGuRcv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404385AbgE1PZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:25:43 -0400
Received: from mout.web.de ([212.227.15.14]:42191 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404080AbgE1PZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590679527;
        bh=WKYadX7JSojRqaBOJBsFx+Raq+xa5V8MW6YVf/cpjlA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=rdGuRcv8ypTuD9ocICT+F7LjyhecR2G+Ofr6z/PcpQdGbJarLCCy5Nx31iIXGiETx
         +VU4SzO8HVCVQYNZgwcBF9RM21fZh8jqq6eW/o4cHKY9yWHXcc0ldvxj9ycjeZ5Cuw
         /w5uuEUaYx5KqDJEfFN/AU+rrJhv5OL1+QqyaDoQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.30.242]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEEMy-1jpLxf0Mem-00FSdH; Thu, 28
 May 2020 17:25:27 +0200
Subject: Re: [v5] workqueue: Remove unnecessary kfree() call in rcu_free_wq()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Zhang Qiang <qiang.zhang@windriver.com>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200527075715.36849-1-qiang.zhang@windriver.com>
 <284c7851-4e89-a00f-a2e6-aa8e2e1f3fce@web.de>
 <DM6PR11MB32573F3884A864ECD586235EFF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <DM6PR11MB3257D6E7E93A518392502809FF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <20200528095703.GH30374@kadam>
 <CAJhGHyD1nV=M=ccycqCMt86GMuZGkO9trbJ=4ti4EzP9kta6iA@mail.gmail.com>
 <20200528122545.GP22511@kadam>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b711731e-f024-5db3-ba9d-cf37e9ae0bef@web.de>
Date:   Thu, 28 May 2020 17:25:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528122545.GP22511@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tFAAGUVknNsYxGEJwm8pnJToVxqhqvPvefcLDzNd/WXxulcSGvy
 Fv7R8BYbpOsS2Ha/OkpPS3Dd94oMHINnVIOjoafaanKFkn+pHaebCMjdVG84ERfiFNb8fol
 fwKpCYX+gu1F36XjSAAWHwyZ80F5IGG85WJMvwg+TTTb12DMMMEvlLJ3eqA/G4sPIWnNlyI
 4Z/Hs65Hg7meOfFERdKbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pQMED9qP4b0=:9jUdBCRgF8g2prYCaXVYmg
 BgSrGmpweERSEyaU723idiaQxhYsrzdFlbuZEV9qbAcMKt3V3fKX971JOcDLdh3qyM9kMrnfN
 gBzCqD7pkKG2Q+jyP+UfGC6NPIyoUK9WAugYXiQ6fxWQ/6zibF9U/1A3YOF4xGTOYu8v7S3aa
 4kmu/H0boFHeBEokkSFSVcSfQA5mts3JMLCx+hWZ21kfCVx/b6Fu1tE1iFGeHcpWB2o4T28JO
 d+pftkLpcixBaWWUPp8IlvhaJfe+ZCmHsxE7LEGHAuD0O0fvtA6mFKNNFH5X+iwXiswgafG/X
 cMvUl8lARVEbQxGUXiHzeLv4CVpD/GND5QuWugBQjcpKRCp8zL74VACr8TRjhiFGCHM34G0Xg
 R3Rr66HQq94A0vHCE5i1shUMLfc8lXT/y9Wap8GZfHw915kNsXVqpg5nuplXp7NPt7Q/3Vw1U
 pQNUYyQM4uwTih8DlsqJ49b6llN/bGTHYY7cTMWPn871nUkDshMNCoXai3lSFQAlH1qGPZvAb
 LCU/vzroOVTjtoWAr3nppvEsU4src9OR9FgwCx/385B3Fn4zybfN8vC2If8Pzy+peT9M1xhtf
 B55NGvj/ppkFtK9yuWBDLcX473OGtBXP7/DOoOl5uHRy9U49YBZCjquekHDWCmFKjkdJ2xIXD
 q+HgUO/jjXiI0jfkllSgPZdruF5aK+z9JWymPNHuNT6vqINnxIllFxE6l7VzoctaTp9xG8pWZ
 RTRODzNbEX5RUBm/LQESAHKxygI2E82sS2NTGi99MxV0EJohxyCFgjTBECIs6wO/N/pLlskKN
 Jml4ol4ZjYur9wCT6xLxwxSfhDZdSH36XiV5YJy2z887NYR44jP5r3LtvDJzWUQ3zsoXZkUBA
 2aTX/g0o0LDsKfNk5dXL3mTxe91paGknlT/u7NEM2qEXFeFNAUw+pi4rG+8MrACIfG1kXi5Tm
 Nvt35XS4vQYoNVhowy52LXQR0dB6mNr6q5xHiBE5FMiU6usXSHXSvCkR6/G8emEt8qxBBmz91
 ASZ6lGFw9+W8UyhdXVlCNybVkSRN1UiOSvDMP2ZnxQtfZOFGUVWnPHRJDDtTzS7PzX8W/lunt
 K4wJlBll+zpJTlqu/wI0TtPBXa/aUzqrK/3xAER1RQcnbGZHlgPiQrLvsuPf6CjvikR6fA9qZ
 J+NWgLrjaW9QLVf6fzSB8eHUEfw0PJlb84ir4x00yV70HeWtiedbVwEBfrRz8daBjj65K1RY1
 2mC/f9n9/IJ+BTlYh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Still, the kfree(NULL) is harmless. But it is cleaner
>> to have the patch. But the changelog is wrong, even after
>> the lengthened debating, and English is not my mother tongue,
>> so I just looked on.
>
> We have tried to tell Markus not to advise people about commit messages

A few concerns were mentioned.


> but he doesn't listen.

I am still listening as usual.

I am offering constructive patch reviews for selected topics.


> He has discouraged some contributors.  :/

There are the usual risks that additional views are occasionally not picke=
d up
in positive ways.

Regards,
Markus
