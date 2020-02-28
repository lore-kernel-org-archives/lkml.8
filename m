Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549D1C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F1320665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="QVDTioGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgB1OGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:06:24 -0500
Received: from mout.web.de ([212.227.15.14]:60457 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgB1OGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582898745;
        bh=j728qNIkf72eDn5YJVGrPL3fCyE3kE7g4ikIilAgwO4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QVDTioGg/JmxsnUWc/M3ew1s3PIPOJfPBjIBu6czXXZ91JJyDxoJpmbEhQ+ej7Sn9
         aMBAz0bhA6WkDUvKeyBLkZ/qhHScFttWgtFC+nCsP18hYUvPfsFWS7kWw2Z8Czas2E
         CKWEPK3/v+d8oFOrp6QZULIkUB8qZDzJH0W4sBb0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.179.252]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LlsUC-1jh15d0q2q-00ZPID; Fri, 28
 Feb 2020 15:05:45 +0100
Subject: Re: [v2 0/1] Documentation: bootconfig: Documentation updates
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <158287861133.18632.12035327305997207220.stgit@devnote2>
 <957cef56-04b0-3889-6c95-a8ed7606b68d@web.de>
 <20200228222311.f5b9448027031b16a3be372a@kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0d7d201c-e313-6129-7cfa-4e61eb31342d@web.de>
Date:   Fri, 28 Feb 2020 15:05:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228222311.f5b9448027031b16a3be372a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:091ao2xyKuX6PdBu5cGt+RgRe/eso75BmIWyHLuZtnjXzczpa0b
 KvBgP0KFuNj2duZp6lEuvkLDPXZx/1qDP8K/GRhn+Q29AsG6m+4DQfbenxabIjRYPf4AwjI
 I3Pp6Wfm0SQqc89YdH7FiLFJQISwHgvAu+oZAkC6fSRxJIhlA8KloN52ZxNjgOZ+MZSGUER
 4xS66md2GZsPkjw+ekHJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jhEvhAGuUtA=:LNdEN/WMAzh4bxx6xncF4k
 p2BC3LR4jwYhF/h315C59SxT/Ghvz7zvX8kuGC4daVSEtQ7pV/DR2+l96o4jg10oFmYOzyFbk
 mbiiv6AXutwyfcezEzWCdCk+gN5CGTAow6aDOEoTPhyttDJ2bcVTYI1SVmqaPHDMytOdsBtny
 h2Qj24tw+PJrazOwM6huolajwKOQtNymtSajmDKvuo27PUCiBFv0DIaQvA1Actn9aD3614N9E
 DX+bN6NC8n2t+2iMf6MzVwkXd52Ajjr42a/sjVoFmQKE+WM0MyFtJJ6aUwr0JA2MRJwRGl2dM
 MKIlp3JTiM9DfGoIfR9/S//HvtAFks3Wf59geIgw1/xANoRuz6DjPIBZb+ci7r9YqEk08TPxS
 TwkwBEUO4JPk01d+LMrUICtmtWJguxJHziPQLwqlmYZOfxDF9DLLAzEMw9u3utIHEwUxSYEPA
 HB7GI12fGVCwAZ2Sh8mTaOCM08B9Dc8DQR7f/+j5ZOwj+dfzqolryyImg5UZKJDDlhqFWs3Jn
 2XMcHkXFMi+SAnMLMOt7A5nIPO8EkKp4Fo5EbJ707Psa5mddLFh8Leh3Ac+MtyYBnnxzBRGLA
 JEzk65qXlX5Z1PnIMJSlgkQJcIbTiADtSj5+e98jd0zF6bsY+5UROww6MArSXzXqTwStMYMkf
 Cp/tr+eW7CUSs5MTcGiMDOXzOo01KtgkoHtj+XMgthL73tjCUmueI1MT4V2m0XTOmStoGIyEP
 2UTpsp52d5eYzbzfEoHxb1hRQpJh+nwkVHtjFfchd2Tn3vNvQD7fJM0OGw+8fC7XMQUd3Dnjq
 HJEFkAAtECPpBZwLXXNML7CkFB1gx/7m0kL5WPWDDOqD3xWBTU8p205sl8lxsoLAI661joNi/
 7dmW6IztRigmNzVRMLGJdJXUWKPRHfOOg2lWVTXtVRp6cSS49NlTOQiGcC5zD+xlpA6CwFT7H
 7fT/qHoJ9JcAIQUJTrgooxgmX6WMeNf82Njcvo9BSxCr+2Cz8eeycf1T3my33QSiQy4V6+dVN
 sMkGFIG91w+YkRJ1bC9QKQN1nPk7CKhVl+twR1+/C18gMyEsRin+HM13032GvVkdlssoi1BjS
 LG00MLI/WXJKmvO5LcCsBJdOXl0dUtCW0O/8torxmcFSe9M42f4cuB2RuYrXWFrf2oGPPhwlp
 pbMYoeZ9cjj6ecUeS5Bxm10dh2tIchgl3emaO3xamlxuvlRqdcY5P+YQkaCRzFBrvAgoFbfev
 t+S9xQd4+2OtRiP65
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Didn't you read the article I shared?

I read also the article =E2=80=9CDon=E2=80=99t Use ISO/IEC 14977 Extended =
Backus-Naur Form (EBNF)=E2=80=9D
by David A. Wheeler.
Some possibilities were pointed out as desirable improvements.


> I actually wrote up the EBNF (ISO/IEC 14977) that was a good pazzle,
> but just a toy.

I hope that this contribution can help to become more productive
in the discussed application domain.
https://lkml.org/lkml/2020/2/27/72
https://lore.kernel.org/patchwork/patch/1200987/
https://lore.kernel.org/linux-doc/158278836196.14966.3881489301852781521.s=
tgit@devnote2/


> I found no one use it to define their data format, according to the arti=
cle,
> including ISO itself (lol!) and there are many local extension,
> including W3C EBNF, and those say "I'm EBNF".

I suggest to reconsider the current situation.


> Well, to say the least, I feel it is quite confused.

Such a view is reasonable.


> So, if you are interested in it, I don't stop you to write it up.

Will the collaboration continue anyhow?


> I just keep away from it.

This is a pity.


Will the clarification become more constructive for remaining challenges?

Regards,
Markus
