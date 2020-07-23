Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6101DC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B44320768
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AOStmqqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGWFdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 01:33:55 -0400
Received: from mout.web.de ([212.227.17.12]:39139 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgGWFdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 01:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595482422;
        bh=QPKOq6BuwyK+vRTc9bGKWfBdj4jWtWo2pzNRnYyaOHw=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=AOStmqqeBmpSYzs8FRu5XAyurUdTX3ALmRhzGj/W7e0p1PemBexdIw6cHdz3m7lsX
         jPowSqFEI4trKk449rH8F3sfdge/vTAEKELyXNPFFstYIdNGtypJlwJHQKhtBN4693
         iU9hlGnnyE5eAaBLkrUyT+gZacWvMN8j4FNu8uec=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.132.31]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVu1U-1kIL7O2YOm-00X2lv; Thu, 23
 Jul 2020 07:33:42 +0200
To:     Hanjun Guo <guohanjun@huawei.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mailbox: pcc: Put the PCCT table for error path
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9e4f09a9-d14f-d76c-5318-d25501c0ec66@web.de>
Date:   Thu, 23 Jul 2020 07:33:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eH392zqk1XFEBEozpn++YUFWJv6gmikomueQN2coP1aKbDj9yzI
 nmHgpAaZv0/xaC3uEoEnsT1WDlsHmlapV626kpeOfgCfFd6QfnXgx01hypHlE45Xc7uBYmr
 Oz3j7PVIZRpJIQdq9U7xCcayu2MsD37EMmQhvMc47/FEcxnKLIwFEQIBAjIEEQIeD7/PpAB
 +20/+aHR2rn/ebacrMHGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O/OFV4naZ6Q=:9zkqLTGyJLeRVsL+7wzduw
 YAOTk18kczr8thneh1jDspHYCvtP73LlG0tAbvSTHBh/kLFoUd2S4sdWrp4d1GT1gWtPz+QtC
 d+rhuRKYlWpw07UG1FgHuwIr/uzQgSdmUgnHtfSALk6g00tjAK9XYrNb06/iIMWLkcJ1H7gIk
 QkwV7r3u7LWBwKT1STP64Nv0ASUATTR6S2Xy0+g7g3kqfXAgAHM0I1E5YyNbwSKO93IyhBI8r
 Q1YczONvz8ZRj9NtYUI1yE9JtWtR1YLSgDHAJ2OtGfk0iOyCnVwc6pDcBGCNeo3j1crxdeeWr
 LdgSqJRyiXnAh8POfjG5MOIWZNAAr4tSKpzH6ENEt/6ByGBvJEg3gcX6bCubopd8Y79rYJbz7
 0O5L4wjBv59oFaVrlVYie9Zjf9l/DE30G4nHlM3tj0Aq7yMPsC7GRzhNaapkLWUYQIpBee1wo
 vt3OBLZX+IwwBelR8Dt5meCWTPX06yya7oabso04KXa6b0+tEfkfrUANh33ejiXTelt+CS/Ep
 fDLQR9ZghVk43zo+ldbJwy+7+smNGyUZDXs6h0tsT4NAUNIiqoxHRYXhSa91ln+dcIY1nTgd8
 /sIzTvmJQnUTNqH1asOqvHyOBQuq8ltgWsnRheGMIcsXwno/UaE7tAAcd4ua1DubtL2xlyqPp
 R70P/owatSVhw7hXq+5VqjQ1LjOCSjJcQCmK9sT/FahaVcyxBYBkQH5/iBnkseOL7RMkFX6Zn
 XW55Gman8UjPcoJ0ZU8ADMMAScSsoWqS0eCQ1OJ1CUPWAje2U9bGwwk5iPfdvkZaat5he7LOf
 4Yv2n7aq0hMLoOtJUi4atOaiyf1pFzCBwgboi9Ew0uwqUs2to7YS/zgGdCe1dl9dYtHMDTWPs
 wZIqnMCse337wFNuEmTa+rDFM7NAFQeKAq1we0CvrGcbvhv4yJcvjzrDh/5+ia9rZ45dBHO8J
 7pavIWFOcipU502NUzUAkizhn7JTL1sNwEq2Oi4vM/aijW99PkpHhUiTuhfmOGEvL6pJv0xSg
 EEm/MASNFaODxY5vNNZOgVlzGXiBQEoHIYF3vnEtvzJ8zoWr18Do8XU2lR4B5fcV0+RMclYtC
 dwyJCr91/nUbi6IKE/cpfDndbvmJu0oHLX1KYO6eui2EJWXaiRaefzN9mXd85XAZvvHDWxhIk
 MWpYzoL09dC5uZ/t11TtqQ/dAKCSn0NkgvQDz9y0HjlXq+yoLNsqr5V9GU0DMoTLbvQd8RUMM
 VkIu+9qnDFHOKiNN2zEre1jHxZ7h2XxIrqDX2KQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> In acpi_pcc_probe(), the PCCT table entries will be used as private
> data for communication chan at runtime, but the table should be put
> for error path.

* An imperative wording can be preferred for the change description,
  can't it?

* Will the tag =E2=80=9CFixes=E2=80=9D become helpful for the commit messa=
ge?

Regards,
Markus
