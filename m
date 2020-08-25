Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4592C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FF82074D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FZyUUewf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgHYTN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHYTNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:13:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1F4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=Btc/GOd+FwhOsG7VGWKCS8CfWy4kGgAQYZx/WUyReHY=; b=FZyUUewfkGqmCNtvI1bU+UxTkt
        yYETZrnesNMMm0DFRSz8EJ3PDJrYYkNX2vL0CMh9AlchwssbgV/8pelAtRrOA72P7bjT4tPZWRkX6
        mH7/K8ST3o+xvHyxzTOXUje2Rw2qzGXJYbDtIrsguO98/esiJ/MZy/+A1JXGbk7sGdUSaH3H4zlWL
        iSCad7q/RIW2qHQJfiHo27Yq5omuegqRlKAQd73hWjCBmAuSkvFyIweKnjzsUSGDt173FJN2SJIMe
        i/kqSeTQA364+AwHhJEGrhKp760f6W7SML2muLbWt1yTc+QHM7jBZe5cFc7Vvyu6v/fADEYv4etE3
        qNRHHbLw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAeNc-0004dM-Hy; Tue, 25 Aug 2020 19:13:12 +0000
Subject: Re: localmodconfig - "intel_rapl_perf config not found!!"
To:     Nathan Royce <nroycea+kernel@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <CALaQ_hqgnPGx2A8XxE+CHxYqGK1z4_hfzo-g-HHbVpLGeOAZ4w@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9ec12e0d-9d07-8c1b-6efc-c3e8cfae409c@infradead.org>
Date:   Tue, 25 Aug 2020 12:13:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALaQ_hqgnPGx2A8XxE+CHxYqGK1z4_hfzo-g-HHbVpLGeOAZ4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/20 11:28 AM, Nathan Royce wrote:
> Intel Haswell
> Linux 5.8.3
> 
> First time I've used localmodconfig ever since reading what it does
> and liking the "supposed" kernel customization specific to the system.
> I only use quotes on "supposed" because I DO still see entries I have
> no interest in (not applicable to my system/needs).
> I don't know if another email would be warranted for localmodconfig
> only or if my expectation of it is unrealistic.
> 
> The "intel_rapl_perf config not found!!" comes up with every .config I try.
> The simplest test I can come up with would be:
> *****
> make defconfig //x86_64_defconfig
> lsmod > lsmod.cfg
> make localmodconfig LSMOD=lsmod.cfg
> *****

so intel_rapl_perf is listed in your lsmod.cfg file:
intel_rapl_perf        16384  2

You say Linux 5.8.3.  I'm guessing that your "make localmodconfig" tree
is Linux 5.8.3 (?).  What kernel version are you running?
I think that it's older, and some file/module names have changed since then.


> 
> lsmod.cfg
> *****
> Module                  Size  Used by
> uinput                 20480  1
> rfcomm                 94208  16
> ccm                    20480  9
> cmac                   16384  5
> algif_hash             16384  2
> bnep                   28672  2
> btrfs                1556480  1
> blake2b_generic        20480  0
> xor                    24576  1 btrfs
> raid6_pq              122880  1 btrfs
> libcrc32c              16384  1 btrfs
> crc32c_generic         16384  0
> nls_iso8859_1          16384  1
> nls_cp437              20480  1
> vfat                   24576  1
> fat                    90112  1 vfat
> snd_usb_audio         311296  0
> snd_usbmidi_lib        45056  1 snd_usb_audio
> snd_rawmidi            45056  1 snd_usbmidi_lib
> snd_seq_device         16384  1 snd_rawmidi
> tda18271               53248  1
> au8522_dig             16384  1
> au8522_common          16384  1 au8522_dig
> au0828                 69632  1
> tveeprom               28672  1 au0828
> dvb_core              176128  1 au0828
> videobuf2_vmalloc      20480  2 dvb_core,au0828
> videobuf2_memops       20480  1 videobuf2_vmalloc
> videobuf2_v4l2         28672  1 au0828
> intel_rapl_msr         20480  0
> btusb                  57344  0
> videodev              274432  2 videobuf2_v4l2,au0828
> btrtl                  24576  1 btusb
> btbcm                  20480  1 btusb
> videobuf2_common       57344  3 videobuf2_v4l2,dvb_core,au0828
> intel_rapl_common      32768  1 intel_rapl_msr
> rc_core                61440  1 au0828
> btintel                32768  1 btusb
> bluetooth             688128  49 btrtl,btintel,btbcm,bnep,btusb,rfcomm
> x86_pkg_temp_thermal    20480  0
> intel_powerclamp       20480  0
> mousedev               24576  0
> ecdh_generic           16384  2 bluetooth
> ecc                    36864  1 ecdh_generic
> crc16                  16384  1 bluetooth
> rtl8821ae             290816  0
> coretemp               20480  0
> snd_hda_codec_hdmi     73728  1
> btcoexist             225280  1 rtl8821ae
> kvm_intel             335872  0
> rtl_pci                36864  1 rtl8821ae
> rtlwifi               139264  3 rtl_pci,rtl8821ae,btcoexist
> kvm                   876544  1 kvm_intel
> iTCO_wdt               16384  0
> mei_hdcp               24576  0
> iTCO_vendor_support    16384  1 iTCO_wdt
> mac80211              954368  3 rtl_pci,rtl8821ae,rtlwifi
> i915                 2703360  60
> snd_hda_codec_realtek   143360  1
> irqbypass              16384  1 kvm
> snd_hda_codec_generic    98304  1 snd_hda_codec_realtek
> ledtrig_audio          16384  2 snd_hda_codec_generic,snd_hda_codec_realtek
> intel_cstate           16384  0
> snd_hda_intel          53248  4
> snd_soc_rt5640        147456  0
> intel_uncore          163840  0
> cfg80211              925696  2 rtlwifi,mac80211
> snd_intel_dspcfg       24576  1 snd_hda_intel
> snd_soc_rl6231         20480  1 snd_soc_rt5640
> intel_rapl_perf        16384  2
> snd_hda_codec         176128  4
> snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec_realtek
> snd_soc_core          311296  1 snd_soc_rt5640
> rfkill                 32768  11 bluetooth,cfg80211
> libarc4                16384  1 mac80211
> snd_compress           32768  1 snd_soc_core
> alx                    57344  0
> input_leds             16384  0
> snd_hda_core          114688  5
> snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_codec_realtek
> i2c_algo_bit           16384  1 i915
> ac97_bus               16384  1 snd_soc_core
> snd_pcm_dmaengine      16384  1 snd_soc_core
> snd_hwdep              20480  2 snd_usb_audio,snd_hda_codec
> mdio                   16384  1 alx
> drm_kms_helper        266240  1 i915
> snd_pcm               159744  9
> snd_hda_codec_hdmi,snd_hda_intel,snd_usb_audio,snd_hda_codec,snd_soc_rt5640,snd_compress,snd_soc_core,snd_hda_core,snd_pcm_dmaengine
> cec                    69632  2 drm_kms_helper,i915
> snd_timer              49152  1 snd_pcm
> mei_me                 49152  1
> intel_gtt              24576  1 i915
> syscopyarea            16384  1 drm_kms_helper
> sysfillrect            16384  1 drm_kms_helper
> sysimgblt              16384  1 drm_kms_helper
> snd                   118784  22
> snd_hda_codec_generic,snd_seq_device,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_usb_audio,snd_usbmidi_lib,snd_hda_codec,snd_hda_codec_realtek,snd_timer,snd_compress,snd_soc_core,snd_pcm,snd_rawmidi
> fb_sys_fops            16384  1 drm_kms_helper
> soundcore              16384  1 snd
> mei                   131072  3 mei_hdcp,mei_me
> i2c_i801               36864  0
> lpc_ich                28672  0
> evdev                  28672  12
> mac_hid                16384  0
> pcspkr                 16384  0
> drm                   606208  16 drm_kms_helper,i915
> agpgart                53248  2 intel_gtt,drm
> ip_tables              36864  0
> x_tables               53248  1 ip_tables
> f2fs                  630784  1
> dm_crypt               49152  2
> serpent_avx2           49152  4
> serpent_avx_x86_64     49152  1 serpent_avx2
> serpent_sse2_x86_64    53248  0
> serpent_generic        32768  5
> serpent_avx2,serpent_sse2_x86_64,serpent_avx_x86_64
> algif_skcipher         16384  2
> af_alg                 36864  10 algif_hash,algif_skcipher
> uas                    32768  0
> usb_storage            81920  3 uas
> sr_mod                 28672  0
> sd_mod                 61440  5
> cdrom                  77824  1 sr_mod
> hid_logitech_hidpp     45056  0
> hid_logitech_dj        28672  0
> hid_generic            16384  0
> usbhid                 65536  1 hid_logitech_dj
> hid                   143360  4
> usbhid,hid_generic,hid_logitech_dj,hid_logitech_hidpp
> crct10dif_pclmul       16384  1
> crc32_pclmul           16384  1
> serio_raw              20480  0
> crc32c_intel           24576  2
> atkbd                  36864  0
> libps2                 20480  1 atkbd
> ghash_clmulni_intel    16384  0
> ahci                   40960  1
> libahci                45056  1 ahci
> libata                303104  2 libahci,ahci
> aesni_intel           372736  13
> scsi_mod              274432  5 sd_mod,usb_storage,uas,libata,sr_mod
> crypto_simd            16384  4
> serpent_avx2,serpent_sse2_x86_64,aesni_intel,serpent_avx_x86_64
> cryptd                 28672  6 crypto_simd,ghash_clmulni_intel
> glue_helper            16384  4
> serpent_avx2,serpent_sse2_x86_64,aesni_intel,serpent_avx_x86_64
> xhci_pci               20480  0
> xhci_hcd              294912  1 xhci_pci
> ehci_pci               20480  0
> ehci_hcd               98304  1 ehci_pci
> i8042                  32768  0
> serio                  28672  4 serio_raw,atkbd,i8042
> dm_mod                167936  10 dm_crypt
> pkcs8_key_parser       16384  0
> nct6775                77824  0
> hwmon_vid              16384  1 nct6775
> crypto_user            16384  0
> *****
> 
> That alone is problematic in that localmodconfig is only going by
> what's in the .config and not filling in the blanks, so I have to
> "make menuconfig" and go through each "module <*> did not have configs
> <CONFIG_*>" and manually set them.
> 
> But even after I take care of all the missing entries, the
> "intel_rapl_perf" still comes up when running localmodconfig again.
> 
> I'm going to assume it has something to do with the naming and it's
> supposed to be associated with "Intel/AMD rapl performance events
> (CONFIG_PERF_EVENTS_INTEL_RAPL)" which I already have set to 'Y'.
> Right below that, I also get 'Use of uninitialized value
> $ENV{"LMC_KEEP"} in split at ./scripts/kconfig/streamline_config.pl
> line 596.', but again that is the sort of thing that may warrant a new
> email specific to localmodconfig author(s). But again maybe not
> because I take it more as a warning given I don't make use of
> LMC_KEEP.
> 


-- 
~Randy

