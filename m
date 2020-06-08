Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C124C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B02F2072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="U+uDvESP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgFHKz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:55:28 -0400
Received: from mout.web.de ([217.72.192.78]:44547 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgFHKzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591613715;
        bh=2IDgC8eQl6HqmXppOxVMev5dv9F1nlZlWXIurSl4N+U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=U+uDvESPVOYhc66c38ACcAoBupxljA5XH7FgCzJg62pxFtwTcO17O+hYs+2dcssqm
         QfQQF+9r++E+TBsRYhymXklBckq0wLmb4LXBXvMwgJ8Q5o0uQTP9jMT3M0zrcsyrdE
         24o5P3tkGhAdZ8c5CaKEZHkWDcmanbd/EaZDmtLA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.116.236]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Md6tt-1j8ukS0a3v-00a3pV; Mon, 08
 Jun 2020 12:55:15 +0200
Subject: Re: usb: gadget: function: printer: Fix use-after-free in
 __lock_acquire()
To:     Qiang Zhang <Qiang.Zhang@windriver.com>, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungtae Kim <kt0755@gmail.com>
References: <5207d179-0a7d-b5ff-af34-102fb21028b5@web.de>
 <DM5PR11MB205835FB50BA296232BC3163FF850@DM5PR11MB2058.namprd11.prod.outlook.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ae59cac9-d770-36bd-ccb2-e5e442bd5e0a@web.de>
Date:   Mon, 8 Jun 2020 12:55:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <DM5PR11MB205835FB50BA296232BC3163FF850@DM5PR11MB2058.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-GB
X-Provags-ID: V03:K1:e6bmZdRHOhVGVGyhDrhy7dMsFBOpyKvNzCP7VcJ5KmXsTAmL3Ln
 C3PZZ3bln5h2vRTNHU6CftmgS9EaMIfRACIspvTgLJ7K865EgQHZawWpOrs3k1A+aJFFVBW
 OsJpqDQjt6l/KPZizk5pXpidKKncKEhb41jV/oBrQA/FC7EQbkgL0ys7NOEcWdnuxSdCr2D
 iBwDEIX+2o5KpOd3sWiPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g0axPKi/NOk=:FsUsgo2Eptma7rjxDZF1rX
 EzSumZ6jU+4oNpGJifV8DRnGnm+ACnbHqyMsIa2pj5OmQm4mh7wu+YHfGMPq66RrasyXTdr5d
 OWHwhxqkiB/aDKBFN+k2zzVs2o1C7qBkGEgYOYqepcWOdckv/myvrlGY3eZj1cB5llUmSb2qE
 Mq4Vw+5I6YJ6WUuBvAT5wEUFJUWqv1HfVeBz532nFBeoffac8GIcAKmsN6wefG/3IBa6hHoPk
 Pmecogs6RQm7662Fdm+Stjmgg2LnJX1aTTmFDJiLJF+o3Yem8bnYIfxRoA2XuVNVPMFBmqU/I
 o5U/QyblZgVN0KYSXcjVNq2Kj2uobYpf4srCviu2zvVhxUJ1sUl7CrHDKo3/RxE6gZd0Uz9Si
 tggk+KXABVqkYt0sBiNhzmdJLGQJ46NZfBANdrNOEb+QWJ0SUpNGgxAAN0qTvVZ+QOehQ/BM2
 vNbxSAiSVzBva8uc2qa2WlM4I8KdiBDiPrP6k9q49KxRny1GNPuoX6ewPyVm+vdL/dh7VzLpl
 Cd32GgaglfDqss05MM8NS3Uu0QpaX0Vg6omHTG4VFH5GZbFPaeBNdsSu/bJ0DPwQ8cHbzE41F
 ABtob6GVjHxO6N/M+cILI6DHxc4arpAPaCTqARemhE7MRBcfiQUYHeCoBFytwZX0JZAebjmKH
 YX3jDzDj7eGuOjyfkT4A6qAt5tE+kur/wZRktx1NWOPZ8z+ekurd6o4fxscpzNbirBPHCQnCc
 TjY4xlG7BIs9ep02ADzfhlQAZ9jYIdg1r93vGoqKHc9WBnGMvSEd2Zigv9v+DiUI/cwqOYBPE
 NvtQJUaXikkFB7LDquiBvMe+CFjnH4vTrb+tJVLITSdcSTWeO6iwLMuoDWLGPmc6FoGW1mHrn
 iug4DhGtVtskmD91/ht5fg0EAHBLdLS8i2MffK+U0kCf/cc7fJE5MliPO/eV+CC73CeDGgO6R
 IVfM5w3xxC+8Qm4U/ot8ZL2mor5quiB5eH2FvJyK3WeETgAg37ImzhIgQ0FAwXTL8xHmCtu91
 kWhhQFog22eiQPMqURUp0sR7MuYdHgql0KsBvovm2sVnx8ADb/tiuSbJyaqDWo74j8osiA1+u
 pj3N5iGf68JiIj06Q9hpGuKiqaQ5wwXfA9y3yNbjBg0ZzJ4H3QRoXg7CWMuo8HfKfW8BBSxWh
 st6BI9QXqMp4JzH8rv//j3E7yK+hfvz9VIfvqF/acYchoCrr9Ct+4eNFLLNcPZNyuzNrtYxC7
 R5HA8PqdsbfqTE2rr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't need to add Fix tag to view the code.

I have got understanding difficulties for this kind of feedback.
How much do you care for corresponding patch review concerns?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=af7b4801030c07637840191c69eb666917e4135d#n183

Regards,
Markus
