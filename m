Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A5FC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B772082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuvUcwki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgAQS5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:57:47 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:37655 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgAQS5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:57:45 -0500
Received: by mail-il1-f196.google.com with SMTP id t8so22125289iln.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 10:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=goN4U1wOfCdpwo3rXJG/sg41e8z5t96+KKPIiY+i7gs=;
        b=nuvUcwkinfykJpBesx24rWQa/0jg0SM2sPzX56BbmbANtpxagF2sTL1AcNVlx26q3P
         DrcWX5ROQqMI5Cm4izYSQXSjhgXWpYUnBjNfzx31+4IhcDduFE1PHxzqGqkFx3GAHZ+l
         kgBAqlHnbO8KqqosP8jNDlUrND538f2U7kNhR/0f25iJSD13Ea9Z/KeQeA1mKEGKVL5p
         P0BMSdv7gA55+P6l2PHojojP8TQRh74AQToNkYvVMie5RHnFwgGrsgXnI8pTtUsiWw9i
         gRxK6og2Paldj/3YYSW5tP8l8WdRylxExmygY1U0gEWqwpYNvNE2IHnhGZEpno92Rwwg
         DXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=goN4U1wOfCdpwo3rXJG/sg41e8z5t96+KKPIiY+i7gs=;
        b=m8M5HhjsDsXA/75/En4M6xhFoAxHurXX0dvKrODx+jg073C7ZEPEf33ubZtK1c24hX
         WiaOVUg60mcbW5EVSTfpA3MJnxLx/LG/yA55y0gk62DlSTdFyBrUWMY7pX5ab9Uw600f
         QtG6aiLznoTspRJieHjoIPwHhR5A9tNeL4TEL0E0iUQhxGnroDTQqltZFEebP2AIuJ57
         dPcli/W+49WQQYGKS4u+KrQcOnoDXjLToOG67hy9dy1z/sKAj6+LfpktS16EmZnQ3507
         YKXB/3zs4A+aVye4J7ElPiJuLesAOt6+wWK/eBq6VHC9AmtHKTmouht7K4/Kk5Ow4zNG
         vgvg==
X-Gm-Message-State: APjAAAV4WQAXc/sK8kSC/yv6WVvXyxzwQCntvIWcKoAsUzjPD9o+Ih+d
        I7Rt3qZOhHnK1XaqLgFSKWU=
X-Google-Smtp-Source: APXvYqw27zV9B46R9rF5rR2qzOdu5axrC0NCoOYIi9u4kPpv9rlFSUOC9lLWltSjzR2ahAbgUNUtXQ==
X-Received: by 2002:a92:cd52:: with SMTP id v18mr4301976ilq.83.1579287464205;
        Fri, 17 Jan 2020 10:57:44 -0800 (PST)
Received: from [100.64.72.109] ([173.245.215.240])
        by smtp.gmail.com with ESMTPSA id i83sm8109915ilf.65.2020.01.17.10.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 10:57:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Rich Persaud <persaur@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [Xen-devel] [PATCH] xen: xen-pciback: Reset MSI-X state when exposing a device
Date:   Fri, 17 Jan 2020 13:57:43 -0500
Message-Id: <C77735B9-0801-4136-B7E5-AFF02290F54D@gmail.com>
References: <20190926101347.GD28704@reaktio.net>
Cc:     "Spassov, Stanislav" <stanspas@amazon.de>,
        "jgross@suse.com" <jgross@suse.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        "jbeulich@suse.com" <jbeulich@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Chao Gao <chao.gao@intel.com>,
        =?utf-8?Q?Marek_Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Jason Andryuk <jandryuk@gmail.com>
In-Reply-To: <20190926101347.GD28704@reaktio.net>
To:     =?utf-8?Q?Pasi_K=C3=A4rkk=C3=A4inen?= <pasik@iki.fi>
X-Mailer: iPad Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 26, 2019, at 06:17, Pasi K=C3=A4rkk=C3=A4inen <pasik@iki.fi> wrote:
>=20
> =EF=BB=BFHello Stanislav,
>=20
>> On Fri, Sep 13, 2019 at 11:28:20PM +0800, Chao Gao wrote:
>>> On Fri, Sep 13, 2019 at 10:02:24AM +0000, Spassov, Stanislav wrote:
>>> On Thu, Dec 13, 2018 at 07:54, Chao Gao wrote:
>>>> On Thu, Dec 13, 2018 at 12:54:52AM -0700, Jan Beulich wrote:
>>>>>>>> On 13.12.18 at 04:46, <chao.gao@intel.com> wrote:
>>>>>> On Wed, Dec 12, 2018 at 08:21:39AM -0700, Jan Beulich wrote:
>>>>>>>>>> On 12.12.18 at 16:18, <chao.gao@intel.com> wrote:
>>>>>>>> On Wed, Dec 12, 2018 at 01:51:01AM -0700, Jan Beulich wrote:
>>>>>>>>>>>> On 12.12.18 at 08:06, <chao.gao@intel.com> wrote:
>>>>>>>>>> On Wed, Dec 05, 2018 at 09:01:33AM -0500, Boris Ostrovsky wrote:
>>>>>>>>>>> On 12/5/18 4:32 AM, Roger Pau Monn=C3=A9 wrote:
>>>>>>>>>>>> On Wed, Dec 05, 2018 at 10:19:17AM +0800, Chao Gao wrote:
>>>>>>>>>>>>> I find some pass-thru devices don't work any more across guest=
 reboot.
>>>>>>>>>>>>> Assigning it to another guest also meets the same issue. And t=
he only
>>>>>>>>>>>>> way to make it work again is un-binding and binding it to pcib=
ack.
>>>>>>>>>>>>> Someone reported this issue one year ago [1]. More detail also=
 can be
>>>>>>>>>>>>> found in [2].
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> The root-cause is Xen's internal MSI-X state isn't reset prope=
rly
>>>>>>>>>>>>> during reboot or re-assignment. In the above case, Xen set mas=
kall bit
>>>>>>>>>>>>> to mask all MSI interrupts after it detected a potential secur=
ity
>>>>>>>>>>>>> issue. Even after device reset, Xen didn't reset its internal m=
askall
>>>>>>>>>>>>> bit. As a result, maskall bit would be set again in next write=
 to
>>>>>>>>>>>>> MSI-X message control register.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Given that PHYSDEVOPS_prepare_msix() also triggers Xen resetti=
ng MSI-X
>>>>>>>>>>>>> internal state of a device, we employ it to fix this issue rat=
her than
>>>>>>>>>>>>> introducing another dedicated sub-hypercall.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Note that PHYSDEVOPS_release_msix() will fail if the mapping b=
etween
>>>>>>>>>>>>> the device's msix and pirq has been created. This limitation p=
revents
>>>>>>>>>>>>> us calling this function when detaching a device from a guest d=
uring
>>>>>>>>>>>>> guest shutdown. Thus it is called right before calling
>>>>>>>>>>>>> PHYSDEVOPS_prepare_msix().
>>>>>>>>>>>> s/PHYSDEVOPS/PHYSDEVOP/ (no final S). And then I would also dro=
p the
>>>>>>>>>>>> () at the end of the hypercall name since it's not a function.
>>>>>>>>>>>>=20
>>>>>>>>>>>> I'm also wondering why the release can't be done when the devic=
e is
>>>>>>>>>>>> detached from the guest (or the guest has been shut down). This=
 makes
>>>>>>>>>>>> me worry about the raciness of the attach/detach procedure: if t=
here's
>>>>>>>>>>>> a state where pciback assumes the device has been detached from=
 the
>>>>>>>>>>>> guest, but there are still pirqs bound, an attempt to attach to=

>>>>>>>>>>>> another guest in such state will fail.
>>>>>>>>>>>=20
>>>>>>>>>>> I wonder whether this additional reset functionality could be do=
ne out
>>>>>>>>>>> of xen_pcibk_xenbus_remove(). We first do a (best effort) device=
 reset
>>>>>>>>>>> and then do the extra things that are not properly done there.
>>>>>>>>>>=20
>>>>>>>>>> No. It cannot be done in xen_pcibk_xenbus_remove() without modify=
ing
>>>>>>>>>> the handler of PHYSDEVOP_release_msix. To do a successful Xen int=
ernal
>>>>>>>>>> MSI-X state reset, PHYSDEVOP_{release, prepare}_msix should be fi=
nished
>>>>>>>>>> without error. But ATM, xen expects that no msi is bound to pirq w=
hen
>>>>>>>>>> doing PHYSDEVOP_release_msix. Otherwise it fails with error code -=
EBUSY.
>>>>>>>>>> However, the expectation isn't guaranteed in xen_pcibk_xenbus_rem=
ove().
>>>>>>>>>> In some cases, if qemu fails to unmap MSIs, MSIs are unmapped by X=
en
>>>>>>>>>> at last minute, which happens after device reset in=20
>>>>>>>>>> xen_pcibk_xenbus_remove().
>>>>>>>>>=20
>>>>>>>>> But that may need taking care of: I don't think it is a good idea t=
o have
>>>>>>>>> anything left from the prior owning domain when the device gets re=
set.
>>>>>>>>> I.e. left over IRQ bindings should perhaps be forcibly cleared bef=
ore
>>>>>>>>> invoking the reset;
>>>>>>>>=20
>>>>>>>> Agree. How about pciback to track the established IRQ bindings? The=
n
>>>>>>>> pciback can clear irq binding before invoking the reset.
>>>>>>>=20
>>>>>>> How would pciback even know of those mappings, when it's qemu
>>>>>>> who establishes (and manages) them?
>>>>>>=20
>>>>>> I meant to expose some interfaces from pciback. And pciback serves
>>>>>> as the proxy of IRQ (un)binding APIs.
>>>>>=20
>>>>> If at all possible we should avoid having to change more parties (qemu=
,
>>>>> libxc, kernel, hypervisor) than really necessary. Remember that such
>>>>> a bug fix may want backporting, and making sure affected people have
>>>>> all relevant components updated is increasingly difficult with their
>>>>> number growing.
>>>>>=20
>>>>>>>>> in fact I'd expect this to happen in the course of
>>>>>>>>> domain destruction, and I'd expect the device reset to come after t=
he
>>>>>>>>> domain was cleaned up. Perhaps simply an ordering issue in the too=
l
>>>>>>>>> stack?
>>>>>>>>=20
>>>>>>>> I don't think reversing the sequences of device reset and domain
>>>>>>>> destruction would be simple. Furthermore, during device hot-unplug,=

>>>>>>>> device reset is done when the owner is alive. So if we use domain
>>>>>>>> destruction to enforce all irq binding cleared, in theory, it won't=
 be
>>>>>>>> applicable to hot-unplug case (if qemu's hot-unplug logic is
>>>>>>>> compromised).
>>>>>>>=20
>>>>>>> Even in the hot-unplug case the tool stack could issue unbind
>>>>>>> requests, behind the back of the possibly compromised qemu,
>>>>>>> once neither the guest nor qemu have access to the device
>>>>>>> anymore.
>>>>>>=20
>>>>>> But currently, tool stack doesn't know the remaining IRQ bindings.
>>>>>> If tool stack can maintaine IRQ binding information of a pass-thru
>>>>>> device (stored in Xenstore?), we can come up with a clean solution
>>>>>> without modifying linux kernel and Xen.
>>>>>=20
>>>>> If there's no way for the tool stack to either find out the bindings
>>>>> or "blindly" issue unbind requests (accepting them to fail), then a
>>>>> "wildcard" unbind operation may want adding. Or, perhaps even
>>>>> better, XEN_DOMCTL_deassign_device could unbind anything left
>>>>> in place for the specified device.
>>>>=20
>>>> Good idea. I will take this advice.
>>>>=20
>>>> Thanks
>>>> Chao
>>>=20
>>> I am having the same issue, and cannot find a fix in either xen-pciback o=
r the Xen codebase.
>>> Was a solution ever pushed as a result of this thread?
>>>=20
>>=20
>> I submitted patches [1] to Xen community. But I didn't get it merged.
>> We made a change in device driver to disable MSI-X during guest OS
>> shutdown to mitigate the issue. But when guest or qemu was crashed, we
>> encountered this issue again. I have no plan to get back to these
>> patches. But if you want to fix the issue completely along what the
>> patches below did, please go ahead.
>>=20
>> [1]: https://lists.xenproject.org/archives/html/xen-devel/2019-01/msg0122=
7.html
>>=20
>> Thanks
>> Chao
>>=20
>=20
> Stanislav: Are you able to continue the work with these patches, to get th=
em merged?=20

What further work is needed for these patches?  Are they only needed for Int=
el i210 NIC PCI passthrough, or are other devices affected?

Rich

