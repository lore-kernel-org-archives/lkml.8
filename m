Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96763C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6771920857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="tABLCRvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgDTKE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:04:29 -0400
Received: from mout.web.de ([212.227.17.11]:51173 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTKE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587377051;
        bh=iZfwtGuB2WyvmGp3l6aad+eUrci6RAGnKD6oOPXHw4g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=tABLCRvXQgRDUnOC+OW6uPCv/P6GYe2pibBYIzPoZE9HvwRKQ9XeW/FX7pbWjLhb7
         SSJDSvlOO6UAdMm95NJHqwpHjI4T+8iX7rh3CVSNvIdMpYw/PuWOLi8rWOkqcwapo8
         V7RHAWtBdBmoY+iBKsruXATbcBtZc5Hue7MR/Y58=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.153.203]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8Qtq-1j54Vl0xn8-00vv71; Mon, 20
 Apr 2020 12:04:11 +0200
Subject: Re: mfd: asic3: Add error checking return in asic3_mfd_probe()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>,
        linux-kernel@vger.kernel.org
References: <b9626e96-4bdb-e7e1-51e7-a99210de4c32@web.de>
 <20200420071339.GG3737@dell> <aa5f9e64-042e-21a1-d252-9856207c7511@web.de>
 <20200420085058.GA3612@dell>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <757587c2-f26d-3328-2ca1-df0230b0989a@web.de>
Date:   Mon, 20 Apr 2020 12:04:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420085058.GA3612@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VaPcYQurcsm+Vls6QzkOAw5L/n5EMyJ6QgRf7tHH5JkO6uPq7/T
 wJ4VxcNV3Z5wRc9Rw2NqrFgxJAERvoIY/0Js5Fje1Qpq4/1NwNufG5RAKRJDbZrzJLL1v4X
 hYjo1k1AwIhRSRD7rXoe3N8qlcn4prh7wGec9kr2aTk3qh4w2VBIxI86J4pCIvuVNLj5Q36
 uXhk+zqNaBupnTH1CWlhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0tJv9lqCuzw=:bSsSm1U3g/hq+0OqGOnLGU
 8Ape1cV17QdARjUI9/iivrfNcfgmmHBa+FMZI7hV/wMdW5SSXbIKQ6azhvHSKb0UbF50/ZsNY
 bIbSBrq1U0g0ZW1d/kcFpYqVD1ZdeST4xHl8drJhh+C/5QSI/9DWTS9j3xQwa5cF9GxMVYknx
 MzRkCtZhaUlje6ZzjUtHtIAzPXOHhZq1FA/WpQexHEEVnmisdfDKYtYb7dC6Gmp1yZOPo8JHr
 u4V9jNOSiXpa7vMI5mHcIS1FPzUn7j+KAum8lU8Ets7j5Q11zOVS79pa+PJuHgAl+VhfWaAuN
 N/u++Cz7Tj1netybMUInxvk8DFPM7Ea1R6TsgkYOcoK9D8WMvlVFnv5a6qM1DvqhyzjR1eJ6c
 72yxWr/KBgKfuBN//B8rDh40JAFkptNWEROdbGbMUU3NHXclbrrnW2CnQC1iKMZvXp9rlumPF
 HWMYzD6EiuHndRnfGzovIyp2uUhuinF42H8ZwLi46LlU6iJgqXGCOUkqm1hFo4MiHL08Uje9i
 /sFj8vS4LHfvk+x8Q4qQ5vJAZ+F1fxPxbYE0d/dFdwCHKD8jtiqsVrbI3zo8VdyMHycArI00+
 th/2RnVMD90VTFqs9/nM7n92jBa0geTdGZVWXUN3OyA5bS9zvrBpA+bczJkDn3bOlUBJfhYJG
 iuRMHLQ2TWog49jITOPMCj1rG+7VQOO92tc0IERzXkrtURg38V3TguWcSH+6rx2qMRTM8dTcj
 i4hxPmiRUg2O5ONQiE4C6KDl9eSKsChA/CIlR94r1bSIUNCLUU1OIZuBZn0h6l9gEk+9uK/mF
 M18XG5tHTZ7Ewvo0S5Hjh+BIJ8hmQme8EEIfxIQ3VYCvIhRIseqE3O1bzeIrpgBj8Hm4hnNp8
 yFL/L/eGVBHB929rPz7ttNJtEvDDwYQx2Qhdp351uhtYTnPIKInCiTSw7Rg18f7eJkT/sHfWr
 oVxoD2A+PWKusFI4IZDji7iLeLsK0F84+tMUUIYnjGprD/1VVSIzmKj4uy3oPqYhiTBoPXhoo
 qMqiePqummz6HiyMh1ufrj0GryuFAM5UzSMSy5Zqu+NiT7xgrFy12F9XJ5yhsBVnHrwgidXLU
 1EvTvcbI7WfVN5wDuu4EOWSQCGzXMG0ZEFcdlwXDP9Cpme2PN4NDrRaQTUJK0/uS4PEeCwFCi
 5K/DcU85mJuyRl2lOyI0devSyKm+wJ941q8uStlx4JiVimtAjcs6C/sokgi49kOIo74p8MxzJ
 sytw5vWrbhwaHHZ8v
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So, it seems this mail did the right thing.

Thanks for another positive feedback.


> Did you use a different mailer,

No.


> or fix/configure your previous one?

My preferred mail program is also evolving over time.
Unfortunately, it seems that this software contains still development chal=
lenges
for the desired support of the field =E2=80=9CIn-Reply-To=E2=80=9D in mail=
to links
(according to the public inbox communication interface).

Regards,
Markus
