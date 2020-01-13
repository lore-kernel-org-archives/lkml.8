Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E893C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF94E2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tSgRZ//k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgAMRLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:11:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36440 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgAMRLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:11:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id x184so5171039pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 09:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TxozZcV9sMOrMojIFRq55NmVEWRnbpuMmipG2qFs8v0=;
        b=tSgRZ//knI+wOG6o7192c5T/RfEp58UAeVfjO0CdKL1o+vKpuvxm1+u65x9/8aaC4a
         VF3NIo6+8XwRD+UBSp3S+kdB23BkT7emrnWgmMuAjp89eeUY+GPXulCTlX3D8ftHfCXK
         LX+/+sedopkIBkhvhkBF3OsEhaKNEL50kD1tgidZwYDqwhoHwPOQOU4kUY/T043K4wS6
         nUmWqbNUBdRCKndjInZWMWuqHZVKn12eSFnrc4C/iUni4fAfYpVY+ZS7ksozVbAk36+b
         aAdXPhpqpxuM+WH0WIYG1qvytVzym5P/0+GRhEj7YQ6ADNFO/16v2sG0vQDBe4GLWaJ+
         vedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TxozZcV9sMOrMojIFRq55NmVEWRnbpuMmipG2qFs8v0=;
        b=bsrJfSN4E2V5ch+QdnpezUffR0aOhCpj0tUUmLgu4Yzavvz5PSUk2nXwVW5DvMbXmo
         S+rtYatFLu4+LBXe38+dtXz/U1GuWrjdQxRMRbdA+/4osPKAalPJ8Le95Mlkmty6dARQ
         m+6L2xsP0cqeAKjAufhk9LDSnVq3W/kqUJ9vC3VwM734zUXsd5ZEWTT1Z3Vacaufs8s0
         Iq9Xz9yhJA/YfECEjvgQk/ZAeKGbIzDn+NcjqOM7iK3UnmGo2P1hQUBmul6frCit5Hs1
         a39/edu4KpbMSK045JirvIpbHSIbYpoxjF7QYU9D5FBki20HVHL6PDm+VpYheANAE5jo
         Ypbg==
X-Gm-Message-State: APjAAAUv86ZSWvPzpzmjN4/CQ6pwqswZSv7tQjUzR9AeB3abqLn20m//
        2DSF+gq+f8FqKq/AdhQ3C9nRhEq71YTNKe/XcuVx9Q==
X-Google-Smtp-Source: APXvYqzpU4X1cBM5WCGzd1V5sbUTwSPopMYyk//1uBBcMoEhtZh8rhMYvEnkETjDK9uHTm4vRgt8IiM3Mndu0st8Zzc=
X-Received: by 2002:a63:590e:: with SMTP id n14mr21403612pgb.10.1578935513283;
 Mon, 13 Jan 2020 09:11:53 -0800 (PST)
MIME-Version: 1.0
References: <202001112351.gy4c3aUU%lkp@intel.com>
In-Reply-To: <202001112351.gy4c3aUU%lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Jan 2020 09:11:41 -0800
Message-ID: <CAKwvOdnRhSXviJ3VGUJbB7XEjSXuTTKJOT8O1crOE6F0F=oJmA@mail.gmail.com>
Subject: Re: [PATCH v3] xen-pciback: optionally allow interrupt enable flag writes
To:     marmarek@invisiblethingslab.com
Cc:     kbuild@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        xen-devel@lists.xenproject.org, jbeulich@suse.com,
        simon@invisiblethingslab.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, sstabellini@kernel.org,
        yuehaibing@huawei.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,
Below is a report from 0day bot build w/ Clang. The warning looks
legit, can you please take a look? Apologies if this has already been
reported.

On Sat, Jan 11, 2020 at 7:48 AM kbuild test robot <lkp@intel.com> wrote:
>
> CC: kbuild-all@lists.01.org
> In-Reply-To: <20200111034347.5270-1-marmarek@invisiblethingslab.com>
> References: <20200111034347.5270-1-marmarek@invisiblethingslab.com>
> TO: "Marek Marczykowski-G=C3=B3recki" <marmarek@invisiblethingslab.com>
> CC: xen-devel@lists.xenproject.org, "Marek Marczykowski-G=C3=B3recki" <ma=
rmarek@invisiblethingslab.com>, Jan Beulich <jbeulich@suse.com>, Simon Gais=
er <simon@invisiblethingslab.com>, Boris Ostrovsky <boris.ostrovsky@oracle.=
com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kern=
el.org>, YueHaibing <yuehaibing@huawei.com>, open list <linux-kernel@vger.k=
ernel.org>, "Marek Marczykowski-G=C3=B3recki" <marmarek@invisiblethingslab.=
com>, Jan Beulich <jbeulich@suse.com>, Simon Gaiser <simon@invisiblethingsl=
ab.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgros=
s@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, YueHaibing <yueha=
ibing@huawei.com>, open list <linux-kernel@vger.kernel.org>
> CC: "Marek Marczykowski-G=C3=B3recki" <marmarek@invisiblethingslab.com>, =
Jan Beulich <jbeulich@suse.com>, Simon Gaiser <simon@invisiblethingslab.com=
>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse=
.com>, Stefano Stabellini <sstabellini@kernel.org>, YueHaibing <yuehaibing@=
huawei.com>, open list <linux-kernel@vger.kernel.org>
>
> Hi "Marek,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on xen-tip/linux-next]
> [also build test WARNING on linux/master linus/master v5.5-rc5 next-20200=
110]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see https://stackoverflow.com/a/374=
06982]
>
> url:    https://github.com/0day-ci/linux/commits/Marek-Marczykowski-G-rec=
ki/xen-pciback-optionally-allow-interrupt-enable-flag-writes/20200111-16224=
3
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git linux=
-next
> config: x86_64-allyesconfig (attached as .config)
> compiler: clang version 10.0.0 (git://gitmirror/llvm_project 016bf03ef6fc=
d9dce43b0c17971f76323f07a684)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/xen/xen-pciback/conf_space_header.c:121:19: warning: variable =
'val' is uninitialized when used here [-Wuninitialized]
>                    if ((cmd->val ^ val) & PCI_COMMAND_INTX_DISABLE) {
>                                    ^~~
>    drivers/xen/xen-pciback/conf_space_header.c:65:9: note: initialize the=
 variable 'val' to silence this warning
>            u16 val;
>                   ^
>                    =3D 0
>    1 warning generated.
>
> vim +/val +121 drivers/xen/xen-pciback/conf_space_header.c
>
>     60
>     61  static int command_write(struct pci_dev *dev, int offset, u16 val=
ue, void *data)
>     62  {
>     63          struct xen_pcibk_dev_data *dev_data;
>     64          int err;
>     65          u16 val;
>     66          struct pci_cmd_info *cmd =3D data;
>     67
>     68          dev_data =3D pci_get_drvdata(dev);
>     69          if (!pci_is_enabled(dev) && is_enable_cmd(value)) {
>     70                  if (unlikely(verbose_request))
>     71                          printk(KERN_DEBUG DRV_NAME ": %s: enable\=
n",
>     72                                 pci_name(dev));
>     73                  err =3D pci_enable_device(dev);
>     74                  if (err)
>     75                          return err;
>     76                  if (dev_data)
>     77                          dev_data->enable_intx =3D 1;
>     78          } else if (pci_is_enabled(dev) && !is_enable_cmd(value)) =
{
>     79                  if (unlikely(verbose_request))
>     80                          printk(KERN_DEBUG DRV_NAME ": %s: disable=
\n",
>     81                                 pci_name(dev));
>     82                  pci_disable_device(dev);
>     83                  if (dev_data)
>     84                          dev_data->enable_intx =3D 0;
>     85          }
>     86
>     87          if (!dev->is_busmaster && is_master_cmd(value)) {
>     88                  if (unlikely(verbose_request))
>     89                          printk(KERN_DEBUG DRV_NAME ": %s: set bus=
 master\n",
>     90                                 pci_name(dev));
>     91                  pci_set_master(dev);
>     92          } else if (dev->is_busmaster && !is_master_cmd(value)) {
>     93                  if (unlikely(verbose_request))
>     94                          printk(KERN_DEBUG DRV_NAME ": %s: clear b=
us master\n",
>     95                                 pci_name(dev));
>     96                  pci_clear_master(dev);
>     97          }
>     98
>     99          if (!(cmd->val & PCI_COMMAND_INVALIDATE) &&
>    100              (value & PCI_COMMAND_INVALIDATE)) {
>    101                  if (unlikely(verbose_request))
>    102                          printk(KERN_DEBUG
>    103                                 DRV_NAME ": %s: enable memory-writ=
e-invalidate\n",
>    104                                 pci_name(dev));
>    105                  err =3D pci_set_mwi(dev);
>    106                  if (err) {
>    107                          pr_warn("%s: cannot enable memory-write-i=
nvalidate (%d)\n",
>    108                                  pci_name(dev), err);
>    109                          value &=3D ~PCI_COMMAND_INVALIDATE;
>    110                  }
>    111          } else if ((cmd->val & PCI_COMMAND_INVALIDATE) &&
>    112                     !(value & PCI_COMMAND_INVALIDATE)) {
>    113                  if (unlikely(verbose_request))
>    114                          printk(KERN_DEBUG
>    115                                 DRV_NAME ": %s: disable memory-wri=
te-invalidate\n",
>    116                                 pci_name(dev));
>    117                  pci_clear_mwi(dev);
>    118          }
>    119
>    120          if (dev_data && dev_data->allow_interrupt_control) {
>  > 121                  if ((cmd->val ^ val) & PCI_COMMAND_INTX_DISABLE) =
{
>    122                          if (value & PCI_COMMAND_INTX_DISABLE) {
>    123                                  pci_intx(dev, 0);
>    124                          } else {
>    125                                  /* Do not allow enabling INTx tog=
ether with MSI or MSI-X. */
>    126                                  switch (xen_pcibk_get_interrupt_t=
ype(dev)) {
>    127                                  case INTERRUPT_TYPE_NONE:
>    128                                  case INTERRUPT_TYPE_INTX:
>    129                                          pci_intx(dev, 1);
>    130                                          break;
>    131                                  default:
>    132                                          return PCIBIOS_SET_FAILED=
;
>    133                                  }
>    134                          }
>    135                  }
>    136          }
>    137
>    138          cmd->val =3D value;
>    139
>    140          if (!xen_pcibk_permissive && (!dev_data || !dev_data->per=
missive))
>    141                  return 0;
>    142
>    143          /* Only allow the guest to control certain bits. */
>    144          err =3D pci_read_config_word(dev, offset, &val);
>    145          if (err || val =3D=3D value)
>    146                  return err;
>    147
>    148          value &=3D PCI_COMMAND_GUEST;
>    149          value |=3D val & ~PCI_COMMAND_GUEST;
>    150
>    151          return pci_write_config_word(dev, offset, value);
>    152  }
>    153
>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology C=
enter
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corpor=
ation
>
> --
> You received this message because you are subscribed to the Google Groups=
 "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/clang-built-linux/202001112351.gy4c3aUU%25lkp%40intel.com.



--=20
Thanks,
~Nick Desaulniers
