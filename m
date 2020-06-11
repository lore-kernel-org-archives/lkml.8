Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AA3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5222078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ah3GZljR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgFKJRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:17:40 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:19040 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgFKJRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:17:39 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200611091737epoutp041ae277bf52a24308158d84a4a78ca19c~XcqeAAvB31191411914epoutp04N
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 09:17:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200611091737epoutp041ae277bf52a24308158d84a4a78ca19c~XcqeAAvB31191411914epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591867057;
        bh=Q5aVFmzqUWy5mgg09MBELMVzAODHky1F6D9/wW++D2I=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Ah3GZljR7qSgmAFJTOf0ekOW/cIcOKGc6zCWipRwi9IpLm/Tv59dldOZYdLgjGPAN
         6DsIQaHLg+1uFfRL4ZIcdIYBkn6UwLVdY2zSxbk7Wj9uRe+AvsgAt3gobODPTHcKCO
         lSyY/u2r3elGrEAzfbSQiEN52z+f/LTQbWyq/aHw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20200611091735epcas2p2ab78f830cfe0fa47fc32667aa4410559~Xcqc07Ff92583925839epcas2p2C;
        Thu, 11 Jun 2020 09:17:35 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.188]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49jJCx0KQjzMqYkc; Thu, 11 Jun
        2020 09:17:33 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.E4.27013.CA6F1EE5; Thu, 11 Jun 2020 18:17:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20200611091732epcas2p1679c29715275a95f62f01c0851764bd9~XcqZx5gPw2102721027epcas2p1T;
        Thu, 11 Jun 2020 09:17:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200611091732epsmtrp16a083955722ba73d512df146e1e53252~XcqZw2XxF2671126711epsmtrp1j;
        Thu, 11 Jun 2020 09:17:32 +0000 (GMT)
X-AuditID: b6c32a48-d35ff70000006985-50-5ee1f6ac5ba2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.2B.08382.CA6F1EE5; Thu, 11 Jun 2020 18:17:32 +0900 (KST)
Received: from KORCO009652 (unknown [12.36.182.243]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200611091732epsmtip1da802e33ceae22cbb81214a2ff17f775~XcqZepHRr2166021660epsmtip1B;
        Thu, 11 Jun 2020 09:17:32 +0000 (GMT)
From:   "???" <wooy88.kim@samsung.com>
To:     "'Dave Martin'" <Dave.Martin@arm.com>,
        "'Mark Rutland'" <mark.rutland@arm.com>
Cc:     "'Catalin       Marinas'" <catalin.marinas@arm.com>,
        "'Bhupesh Sharma'" <bhsharma@redhat.com>,
        "'Julien Grall'" <julien.grall@arm.com>,
        "'Vincenzo Frascino'" <vincenzo.frascino@arm.com>,
        "'Will Deacon'" <will@kernel.org>, <yhwan.joo@samsung.com>,
        "'Anisse Astier'" <aastier@freebox.fr>,
        "'Marc Zyngier'" <maz@kernel.org>,
        "'Allison Randal'" <allison@lohutok.net>,
        "'Sanghoon Lee'" <shoon114.lee@samsung.com>,
        <jihun.kim@samsung.com>, "'Kees Cook'" <keescook@chromium.org>,
        "'Suzuki K Poulose'" <suzuki.poulose@arm.com>,
        "'Wooki Min'" <wooki.min@samsung.com>,
        "'Kristina Martsenko'" <kristina.martsenko@arm.com>,
        "'Jeongtae Park'" <jtp.park@samsung.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        "'Steve Capper'" <steve.capper@arm.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "'James Morse'" <james.morse@arm.com>,
        "'Sudeep Holla'" <sudeep.holla@arm.com>, <dh.han@samsung.com>
In-Reply-To: <20200608103340.GA31466@arm.com>
Subject: RE: [PATCH] arm64: fpsimd: Added API to manage fpsimd state inside
 kernel
Date:   Thu, 11 Jun 2020 18:17:32 +0900
Message-ID: <000001d63fd1$23430d80$69c92880$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGxBksMB01Mym8I2jEMUBwtLj9rogIZEnF2AoMWIKECIyRV0KjmWITQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTVxjGd3rv7YeOca0dnHW4NR3gZCu2zOKBAcEp5Oo2wub2B5uCFa6U
        rbRNC3MOMxFJ5UuYM8jkewHkwxJIqQgO3AZklbIQPgSDVCoDdCBfGxPCwnQtFxP+e855f895
        3+ecHC7Gv8QRchPUSbROrVCJ2Vvw5s5dcolxeTxaOtgWgKoGijFUe/spjn6ctRJo4WoOQGkl
        bQDNGQowdK6igY3st6pZ6FHVOBt11Q+xkKE8Av2enYjsFgOBTBPDBBq8WcxGVXf7Wai1uJtA
        49OjGPp+tpmFqq0tOLoyOgpQkykfQ+1PV3GUbpOjstFrLFR0u4IIFVLGUiOgilL7caohz45T
        prpMNjXf28uhfi4xcqimyjPUX7OTHGrh1hCbyjXXAWrJ9Frk1s9UQUpaEUfrRLQ6VhOXoI4P
        Fr9/OGZ/jNxfKpPIAtBesUitSKSDxQc+iJSEJ6gc+cWirxSqZMdWpEKvF+8OCdJpkpNokVKj
        TwoW09o4lVYm0/rqFYn6ZHW8b6wmMVAmlfrJHeQxlXLt8TBHm+369dhgJZEKzr+YBbhcSO6B
        S0+OZwEel0+2ANibGpYFtjj03w49e59gFssAXvhlEDgpp2Gh+TzOFNoBtJ6d3aCmAfyzoJHl
        pNikJ6yecRZ4XAH5Cezv+YfthDDyHgdOXOxeL/BICbzZs4g79XYHlDXZvt4CJ73gs+ryde1C
        BsC20kcEo7fB7iuT6zxGSuFCbxnG6NfhjblijBlPBFenrm40DocTNjNgGAEsyjRgziEgaeXB
        set9OGM4AO32HBajt8MZi5nDaCGczjNs6BRYXnGBw5gzAPwhs3PD8A40l1hZzE2+AbvubQz3
        Eszo/I/DbLvADAOfoT3hiqmH/fz4BzMD2HdAXLgpWuGmaIWbohVuilAO8DrgRmv1ifG03k+7
        Z/Nzm8D67/ChWkDR3KJvB2BxQQeAXEwscNnmPh7Nd4lTnPqG1mlidMkqWt8B5I7bvogJX47V
        OL6XOilGJvfz95cGyJHc3w+J3V3mA/ui+WS8Ion+kqa1tO65j8XlCVNZgaT6UOja0NS5a/yO
        hm/9a5pLO2uKQ+R+Oe+t3HCt7Vlmex+MsHi4vhXx2OfTULcCEiv3qCmaPj1vlobtndqff9n1
        9O6jHn0nhPvGeltzG2wtbcgWlr92/aGNHzWCV8cuay+pDw6fufN50ODiq2/uILxfGL+fHtKU
        kiJ/uO+UVpTxsSDvROnJtJIjxIAyKqFl1yG2tRmWKt3XsIV3c6OaLk9GlaHDnuGNAtJraeYL
        w4rJ0ujq/ZGHba2fuPvHyOhOiWSHoOuVI5aTxvrs354cM0cQqgeyX2OI1X/f3pnOk1l6PlT+
        NC1Mc6s/O1Ypq/EOGvE6unRcbzfX3nF7ZmzdOtUlxvVKhcwH0+kV/wMdzYR6pgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7bCSnO6abw/jDE6ckrBYemkOs8XKE/9Y
        LBa+OcVq8X5ZD6NF09w9jBZv26YzWzQvXs9mcX/fciaL50sfslkcWXuVyaJtgZ/Fme5ci/vH
        21gtNj2+xmpxedccNoul1y8yWeycc5LV4uHL28wWk95sY7JYfmoHi8XM27cZLTZvmspssfff
        TxaLljumFvNvr2aymH1iMauDlMeaeWsYPWY3XGTxWN9/n8Vj06pONo93586xe+yfu4bdY/OS
        eo+Pb56we7zfd5XNo2/LKkaPz5vkArijuGxSUnMyy1KL9O0SuDL+vL7GXtDNX3Hv8hLWBsZ2
        ni5GTg4JAROJ99vaWboYuTiEBHYzSnRemMAKkZCSONSwkB3CFpa433IELC4k8JxRYsZ8aRCb
        TUBFYvmrN2BxEYEQiYUHL7GCDGIWeMcusbizhwli6i1GiVmXJ7GAVHEK6ErsOv0BzBYWCJLY
        cRBiKouAqsT/5QsYQWxeAUuJPfOes0LYghInZz4Bq2cWMJI4d2g/G4QtL7H97RxmiOsUJH4+
        XQZ1hZvE4ztbGCFqRCRmd7YxT2AUnoVk1Cwko2YhGTULScsCRpZVjJKpBcW56bnFhgWGeanl
        esWJucWleel6yfm5mxjBKURLcwfj9lUf9A4xMnEwHmKU4GBWEuEVFH8YJ8SbklhZlVqUH19U
        mpNafIhRmoNFSZz3RuHCOCGB9MSS1OzU1ILUIpgsEwenVANTv8SK5N0mH9arrlXqef9WIL7s
        l2cn++5am2CnSZ/X2b/IWHTcT663zMbn75w3mycWpth1S/YUdhRY2R7ZHVGt9H2+yp8jSXqZ
        HWeDUj/dssnWCzn5v+vo5U8Pbm6ocPmfvd5729zz53fseSVtb/LgtJqIvHbm0b3ZW6ft3dYc
        8dx43lSJlBOKdfphNf8FtDwPX90Z1cG/SPiV3bpFP14VWe6M2S5Zs0X9jM+XZcxCk4INP7vc
        Wv5CbVdCGZuD09o/Le2/1V/vPN7221r8Vfwawyuuf5oDdcMdN54xEElRbRbMmzc5bH/Hrfw+
        73suU7cfnjO7feeHvxuTzkT/MZiXl6i8jL3FoOfI57CGOms9JZbijERDLeai4kQA57+L8JAD
        AAA=
X-CMS-MailID: 20200611091732epcas2p1679c29715275a95f62f01c0851764bd9
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200605073214epcas2p1576f3f90dbcefaad6180f2559ca5980d
References: <CGME20200605073214epcas2p1576f3f90dbcefaad6180f2559ca5980d@epcas2p1.samsung.com>
        <20200605073052.23044-1-wooy88.kim@samsung.com>
        <20200605103705.GD85498@C02TD0UTHF1T.local> <20200608103340.GA31466@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dave Martin & Mark Rutland

Thank you for your kind answer.

> On Fri, Jun 05, 2020 at 11:37:05AM +0100, Mark Rutland wrote:
> > Hi Wooyeon,
> >
> > There are a *lot* of people Cc' here, many of whomo will find this
> > irrelevant. Please try to keep the Cc list constrained to a reasonable
> > number of interested parties.

I have adjusted the mailing list according to your opinion.

> > Please introduce the problem you are trying to solve in more detail.
> > We already have kernel_neon_{begin,end}() for kernel-mode NEON; why is
> > that not sufficient for your needs? Please answer this before
> > considering other details.
> >
> > What do you want to use this for?

> Ack, this looks supicious.  Can you explain why your usecase _requires_
> FPSIMD in hardirq context?
> 
> For now, these functions are strictly for EFI use only and should never be
> used by modules.

I am in charge of camera driver development in Samsung S.LSI division.

In order to guarantee real time processing
such as Camera 3A algorithm in current or ongoing projects,
prebuilt binary is loaded and used in kernel space, rather than user space.
Because the binary is built with other standard library which could use
FPSIMD register,
kernel API should keep the original FPSIMD state for other user tasks.
It is mostly used for internal kernel operation including hardirq context.
(ex> hardIRQ context, kernel API called by user, kernel task)

In the case of the kernel_neon_begin / kernel_neon_end that you mentioned,
there is a limitation that cannot be used in hardirq context.
Also, if another kernel task switching occurs while kernel API is being
used,
fpsimd register corruption may occur.
In addition to kernel_neon_* API,
It was necessary to add and utilize API considering kernel context.
It is for this reason that I have tried to utilize efi_fpsimd_begin/end.

Regards
Wooyeon Kim

