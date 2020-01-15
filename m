Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E79C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139D42187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="LeiiU8QK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgAOQsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:48:23 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:4703 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbgAOQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1579106903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1csUV+owa2Ns8RWDJK1EbnDuyaavppRtNAR5sZdtg6I=;
  b=LeiiU8QK6ANkbszesJIJgWtciiqJEUPMl1X7Z1AC4RaLBfcEwM0TYNpM
   gJLIXCpTL/P8pLv5xIddwIaBYRGNU8iaaZGFrftOrDX5TS2QTA9P4Zij4
   MF8gbwqU2EzrqDy/CHD/Ef0TsS6HPw3iYJrRU/q0gzKUPP1v7SwCJCXMc
   w=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: 8O8U36RdALUjJZnvBh66/2S0V8EPib1tyGks6UUnU5uQ2g8okjj9+uRcPSqgIJ4bT9VjZZNW5G
 AzYcbiwZouayfWaAxOliCAfEGnn2Ncqip9HL9Q67J5euEW2U2nAH5Lau7TU90WVc+yIR0AwScS
 v21c5hzHGqyoWvh3lMgPrQPB+qBWN1ozSGqkuKjxLi1LLehLVeQ9CwHCg2UiVh4bbgjc6j7ASv
 0RM2oXO4+m7mgZGpKJhgXeyZl8Lsp03eM7s/3JZsg6q+E1hdNQzAUrDrsIodplbX/nhblCW/o6
 Zts=
X-SBRS: 2.7
X-MesageID: 10951819
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,323,1574139600"; 
   d="scan'208";a="10951819"
Date:   Wed, 15 Jan 2020 17:48:15 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>
CC:     <xen-devel@lists.xenproject.org>, Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        Jan Beulich <jbeulich@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH v4] xen-pciback: optionally allow interrupt
 enable flag writes
Message-ID: <20200115164815.GO11756@Air-de-Roger>
References: <20200115014643.12749-1-marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200115014643.12749-1-marmarek@invisiblethingslab.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL01.citrite.net (10.69.22.125)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 02:46:29AM +0100, Marek Marczykowski-Górecki wrote:
> QEMU running in a stubdom needs to be able to set INTX_DISABLE, and the
> MSI(-X) enable flags in the PCI config space. This adds an attribute
> 'allow_interrupt_control' which when set for a PCI device allows writes
> to this flag(s). The toolstack will need to set this for stubdoms.
> When enabled, guest (stubdomain) will be allowed to set relevant enable
> flags, but only one at a time - i.e. it refuses to enable more than one
> of INTx, MSI, MSI-X at a time.
> 
> This functionality is needed only for config space access done by device
> model (stubdomain) serving a HVM with the actual PCI device. It is not
> necessary and unsafe to enable direct access to those bits for PV domain
> with the device attached. For PV domains, there are separate protocol
> messages (XEN_PCI_OP_{enable,disable}_{msi,msix}) for this purpose.
> Those ops in addition to setting enable bits, also configure MSI(-X) in
> dom0 kernel - which is undesirable for PCI passthrough to HVM guests.
> 
> This should not introduce any new security issues since a malicious
> guest (or stubdom) can already generate MSIs through other ways, see
> [1] page 8. Additionally, when qemu runs in dom0, it already have direct
> access to those bits.
> 
> This is the second iteration of this feature. First was proposed as a
> direct Xen interface through a new hypercall, but ultimately it was
> rejected by the maintainer, because of mixing pciback and hypercalls for
> PCI config space access isn't a good design. Full discussion at [2].
> 
> [1]: https://invisiblethingslab.com/resources/2011/Software%20Attacks%20on%20Intel%20VT-d.pdf
> [2]: https://xen.markmail.org/thread/smpgpws4umdzizze
> 
> [part of the commit message and sysfs handling]
> Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
> [the rest]
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

Some minor nits below, but LGTM:

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

> ---
> Changes in v4:
>  - fix incorrect variable used
>  - don't enable INTx when already enabled
> Changes in v3:
>  - return bitmap (or negative error) from
>    xen_pcibk_get_interrupt_type(), to implicitly handle cases when
>    multiple interrupt types are already enabled - disallow enabling in
>    that case
>  - add documentation
> Changes in v2:
>  - introduce xen_pcibk_get_interrupt_type() to deduplicate current
>    INTx/MSI/MSI-X state check
>  - fix checking MSI/MSI-X state on devices not supporting it
> ---
>  .../ABI/testing/sysfs-driver-pciback          | 13 +++
>  drivers/xen/xen-pciback/conf_space.c          | 36 ++++++++
>  drivers/xen/xen-pciback/conf_space.h          |  7 ++
>  .../xen/xen-pciback/conf_space_capability.c   | 88 +++++++++++++++++++
>  drivers/xen/xen-pciback/conf_space_header.c   | 19 ++++
>  drivers/xen/xen-pciback/pci_stub.c            | 66 ++++++++++++++
>  drivers/xen/xen-pciback/pciback.h             |  1 +
>  7 files changed, 230 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-pciback b/Documentation/ABI/testing/sysfs-driver-pciback
> index 6a733bfa37e6..566a11f2c12f 100644
> --- a/Documentation/ABI/testing/sysfs-driver-pciback
> +++ b/Documentation/ABI/testing/sysfs-driver-pciback
> @@ -11,3 +11,16 @@ Description:
>                  #echo 00:19.0-E0:2:FF > /sys/bus/pci/drivers/pciback/quirks
>                  will allow the guest to read and write to the configuration
>                  register 0x0E.
> +
> +What:           /sys/bus/pci/drivers/pciback/allow_interrupt_control
> +Date:           Jan 2020
> +KernelVersion:  5.5
> +Contact:        xen-devel@lists.xenproject.org
> +Description:
> +                List of devices which can have interrupt control flag (INTx,
> +                MSI, MSI-X) set by a connected guest. It is meant to be set
> +                only when the guest is a stubdomain hosting device model (qemu)
> +                and the actual device is assigned to a HVM. It is not safe
> +                (similar to permissive attribute) to set for a devices assigned
> +                to a PV guest. The device is automatically removed from this
> +                list when the connected pcifront terminates.
> diff --git a/drivers/xen/xen-pciback/conf_space.c b/drivers/xen/xen-pciback/conf_space.c
> index 60111719b01f..7697001e8ffc 100644
> --- a/drivers/xen/xen-pciback/conf_space.c
> +++ b/drivers/xen/xen-pciback/conf_space.c
> @@ -286,6 +286,42 @@ int xen_pcibk_config_write(struct pci_dev *dev, int offset, int size, u32 value)
>  	return xen_pcibios_err_to_errno(err);
>  }
>  
> +int xen_pcibk_get_interrupt_type(struct pci_dev *dev)

const for *dev.

> +{
> +	int err;
> +	u16 val;
> +	int ret = 0;
> +
> +	err = pci_read_config_word(dev, PCI_COMMAND, &val);
> +	if (err)
> +		return err;
> +	if (!(val & PCI_COMMAND_INTX_DISABLE))
> +		ret |= INTERRUPT_TYPE_INTX;
> +
> +	/* Do not trust dev->msi(x)_enabled here, as enabling could be done
> +	 * bypassing the pci_*msi* functions, by the qemu.
> +	 */
> +	if (dev->msi_cap) {
> +		err = pci_read_config_word(dev,
> +				dev->msi_cap + PCI_MSI_FLAGS,
> +				&val);
> +		if (err)
> +			return err;
> +		if (val & PCI_MSI_FLAGS_ENABLE)
> +			ret |= INTERRUPT_TYPE_MSI;
> +	}
> +	if (dev->msix_cap) {
> +		err = pci_read_config_word(dev,
> +				dev->msix_cap + PCI_MSIX_FLAGS,
> +				&val);
> +		if (err)
> +			return err;
> +		if (val & PCI_MSIX_FLAGS_ENABLE)
> +			ret |= INTERRUPT_TYPE_MSIX;
> +	}
> +	return ret;
> +}
> +
>  void xen_pcibk_config_free_dyn_fields(struct pci_dev *dev)
>  {
>  	struct xen_pcibk_dev_data *dev_data = pci_get_drvdata(dev);
> diff --git a/drivers/xen/xen-pciback/conf_space.h b/drivers/xen/xen-pciback/conf_space.h
> index 22db630717ea..6ba6aa26dcee 100644
> --- a/drivers/xen/xen-pciback/conf_space.h
> +++ b/drivers/xen/xen-pciback/conf_space.h
> @@ -65,6 +65,11 @@ struct config_field_entry {
>  	void *data;
>  };
>  
> +#define INTERRUPT_TYPE_NONE 0
> +#define INTERRUPT_TYPE_INTX 1
> +#define INTERRUPT_TYPE_MSI  2
> +#define INTERRUPT_TYPE_MSIX 4

Nit: those being a bitmap I would write them as:

#define INTERRUPT_TYPE_NONE (1<<0)
#define INTERRUPT_TYPE_INTX (1<<1)
#define INTERRUPT_TYPE_MSI  (1<<2)
#define INTERRUPT_TYPE_MSIX (1<<3)

And would place them together with the function prototype below where
they are used.

> +
>  extern bool xen_pcibk_permissive;
>  
>  #define OFFSET(cfg_entry) ((cfg_entry)->base_offset+(cfg_entry)->field->offset)
> @@ -126,4 +131,6 @@ int xen_pcibk_config_capability_init(void);
>  int xen_pcibk_config_header_add_fields(struct pci_dev *dev);
>  int xen_pcibk_config_capability_add_fields(struct pci_dev *dev);
>  
> +int xen_pcibk_get_interrupt_type(struct pci_dev *dev);
> +
>  #endif				/* __XEN_PCIBACK_CONF_SPACE_H__ */
> diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
> index e5694133ebe5..d3a846119974 100644
> --- a/drivers/xen/xen-pciback/conf_space_capability.c
> +++ b/drivers/xen/xen-pciback/conf_space_capability.c
> @@ -189,6 +189,84 @@ static const struct config_field caplist_pm[] = {
>  	{}
>  };
>  
> +static struct msi_msix_field_config {
> +	u16 enable_bit; /* bit for enabling MSI/MSI-X */
> +	int int_type; /* interrupt type for exclusiveness check */

unsigned int would be a better fit here, since you will never store a
negative value AFAICT.

> +} msi_field_config = {
> +	.enable_bit = PCI_MSI_FLAGS_ENABLE,
> +	.int_type = INTERRUPT_TYPE_MSI,
> +}, msix_field_config = {
> +	.enable_bit = PCI_MSIX_FLAGS_ENABLE,
> +	.int_type = INTERRUPT_TYPE_MSIX,
> +};
> +
> +static void *msi_field_init(struct pci_dev *dev, int offset)
> +{
> +	return &msi_field_config;
> +}
> +
> +static void *msix_field_init(struct pci_dev *dev, int offset)
> +{
> +	return &msix_field_config;
> +}
> +
> +static int msi_msix_flags_write(struct pci_dev *dev, int offset, u16 new_value,
> +				void *data)
> +{
> +	int err;
> +	u16 old_value;
> +	const struct msi_msix_field_config *field_config = data;
> +	const struct xen_pcibk_dev_data *dev_data = pci_get_drvdata(dev);
> +
> +	if (xen_pcibk_permissive || dev_data->permissive)
> +		goto write;
> +
> +	err = pci_read_config_word(dev, offset, &old_value);
> +	if (err)
> +		return err;
> +
> +	if (new_value == old_value)
> +		return 0;
> +
> +	if (!dev_data->allow_interrupt_control ||
> +	    (new_value ^ old_value) & ~field_config->enable_bit)
> +		return PCIBIOS_SET_FAILED;
> +
> +	if (new_value & field_config->enable_bit) {
> +		/* don't allow enabling together with other interrupt types */
> +		int int_type = xen_pcibk_get_interrupt_type(dev);

A newline here would make this easier to read I think.

Thanks, Roger.
